//
//  TJPHomeViewController.swift
//  TJPDouYuZB
//
//  Created by Walkman on 2016/11/9.
//  Copyright © 2016年 walkman. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH : CGFloat = 40

class TJPHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        
    }
    
    // MARK: - 懒加载
    fileprivate lazy var pageTitleView : TJPPageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBar, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "去玩"]
        let titleView = TJPPageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.clear
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView: TJPPageContentView = {
        //确定frame的内容
        let contentH = kScreenH - kStatusBarH + kNavigationBar + kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBar + kTitleViewH, width: kScreenW, height: contentH)
       
        //确定所有子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = TJPPageContentView(frame: contentFrame,
                                             childVcs: childVcs,
                                             parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
}





// MARK: - 设置UI
extension TJPHomeViewController {
    fileprivate func setupUI() {
        
        //设置导航栏
        setupNavigationBar()
        
        
        //添加titleView
        view.addSubview(pageTitleView)
        
        //添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.brown
        
        
    
    }
    
    
    fileprivate func setupNavigationBar() {
        
        //不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "logo")
        
        //设置右item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(image: "image_my_history", selectedImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(image: "btn_search", selectedImage: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(image: "Image_scan", selectedImage: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]

    }
    
}


// MARK: - 遵守PageTitleView协议
extension TJPHomeViewController : TJPPageTitleViewDelegate {
    func pageTitleView(_ titleView: TJPPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
}

// MARK: - 遵守TJPPageContentViewDelegate协议
extension TJPHomeViewController : TJPPageContentViewDelegate {
    func pageContentView(contentView: TJPPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.settitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}












