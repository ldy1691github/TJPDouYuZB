//
//  UIColor+Extension.swift
//  TJPDouYuZB
//
//  Created by Walkman on 2016/11/10.
//  Copyright © 2016年 walkman. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)

    }
}
