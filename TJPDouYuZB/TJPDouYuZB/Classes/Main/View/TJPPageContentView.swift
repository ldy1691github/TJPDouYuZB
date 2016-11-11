//
//  TJPPageContentView.swift
//  TJPDouYuZB
//
//  Created by Walkman on 2016/11/10.
//  Copyright © 2016年 walkman. All rights reserved.
//

import UIKit

fileprivate let ContentCellID = "ContentCellID"

protocol TJPPageContentViewDelegate : class {
    func pageContentView(contentView : TJPPageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}


class TJPPageContentView: UIView {
    
    //定义属性
    fileprivate var childVcs: [UIViewController]
    fileprivate weak var parentViewController: UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    weak var delegate : TJPPageContentViewDelegate?

    // MARK: - 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 懒加载
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        //1.创建Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0 //行间距
        layout.minimumInteritemSpacing = 0 //item间距
        layout.scrollDirection = .horizontal  //滚动方向 水平
        
        //创建CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //水平方向指示器
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    
    }()

}


// MARK: - 设置UI
extension TJPPageContentView {
    fileprivate func setupUI() {
        //1.将所有子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2.添加UICollectionView,用于在cell中存放控制器
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
}
// MARK: - 遵守UICollectionViewDataSource
extension TJPPageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        
        return cell
    }
    
}
// MARK: - 遵守UICollectionViewDelegate
extension TJPPageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            //1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else {//右滑
            //计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        //将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)

        
        
        
    }
}


// MARK: - 对外暴露的方法
extension TJPPageContentView {
    func setCurrentIndex(currentIndex : Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}


