//
//  UIBarButtonItem-Extension.swift
//  TJPDouYuZB
//
//  Created by Walkman on 2016/11/9.
//  Copyright © 2016年 walkman. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    /*
    class func createItem(image: String, selectedImage: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: image), for: UIControlState.normal)
        btn.setImage(UIImage.init(named: selectedImage), for: UIControlState.highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem.init(customView: btn)
    }
     */
    convenience init(image: String, selectedImage: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: image), for: UIControlState.normal)
        if selectedImage != "" {
            btn.setImage(UIImage.init(named: selectedImage), for: UIControlState.highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
