//
//  TJPMainViewController.swift
//  TJPDouYuZB
//
//  Created by Walkman on 2016/11/9.
//  Copyright © 2016年 walkman. All rights reserved.
//

import UIKit

class TJPMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyboardName: "Home")
        addChildVC(storyboardName: "Live")
        addChildVC(storyboardName: "Follow")
        addChildVC(storyboardName: "Profile")
        
        
        
        
    }
    
    private func addChildVC(storyboardName: String) {
        //通过sb获取控制器
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = sb.instantiateInitialViewController()
        
        //将childvc作为子控制器
        addChildViewController(vc!)
    }
}
