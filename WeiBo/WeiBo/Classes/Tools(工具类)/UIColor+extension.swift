//
//  UIColor+extension.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

extension UIColor {

    class func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor{
        
        let r = r / 255.0
        let g = g / 255.0
        let b = b / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    //随机颜色
    class func randomColor () -> UIColor {
        let r = arc4random() % 255
        let g = arc4random() % 255
        let b = arc4random() % 255
        
        let red = CGFloat(r)/255.0
        let green = CGFloat(g)/255.0
        let blue = CGFloat(b)/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
