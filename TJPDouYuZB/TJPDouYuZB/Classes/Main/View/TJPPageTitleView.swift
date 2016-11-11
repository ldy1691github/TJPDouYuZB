//
//  TJPPageTitleView.swift
//  TJPDouYuZB
//
//  Created by Walkman on 2016/11/9.
//  Copyright © 2016年 walkman. All rights reserved.
//

import UIKit

protocol TJPPageTitleViewDelegate : class {
    func pageTitleView(_ titleView : TJPPageTitleView, selectedIndex index : Int)
    
}

fileprivate let kScrollLineH : CGFloat = 2

class TJPPageTitleView: UIView {
    
    // MARK: - 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : TJPPageTitleViewDelegate?
    

    // MARK: - 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()

}

// MARK: - 设置UI
extension TJPPageTitleView {
    fileprivate func setupUI() {
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的label
        setupTitleLabels()
        
        //3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    
    }
    fileprivate func setupTitleLabels() {
        
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //创建label
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = NSTextAlignment.center
            
            //设置frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将label添加到scrollView
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给label添加属性 
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        
        }
    }
    
    
    
    fileprivate func setupBottomLineAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollLine
        //获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        //设置scrollLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


// MARK: - 监听label点击
extension TJPPageTitleView {
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer) {
        //获取label
        guard let currentLabel =  tapGes.view as? UILabel else {
            return
        }
        
        //之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //保存下标
        currentIndex = currentLabel.tag
        
        //切换文字颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        //滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.25  , animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        
        //通知代理做事情
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

// MARK: - 对外暴露的方法
extension TJPPageTitleView {
    func settitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
    }
}




