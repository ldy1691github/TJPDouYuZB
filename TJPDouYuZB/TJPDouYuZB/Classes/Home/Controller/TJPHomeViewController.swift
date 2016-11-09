//
//  TJPHomeViewController.swift
//  TJPDouYuZB
//
//  Created by Walkman on 2016/11/9.
//  Copyright © 2016年 walkman. All rights reserved.
//

import UIKit

class TJPHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
}
// MARK: - 设置UI
extension TJPHomeViewController {
    fileprivate func setupUI() {
    //设置导航栏
        setupNavigationBar()
        
    
    }
    
    
    fileprivate func setupNavigationBar() {
        
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











