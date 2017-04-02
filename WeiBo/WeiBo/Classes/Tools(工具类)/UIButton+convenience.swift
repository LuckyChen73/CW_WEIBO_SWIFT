//
//  UIButton+extension.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

extension UIButton {

    convenience init(title: String?,
                     titleColor: UIColor? = UIColor.gray,
                     fontSize: CGFloat? = 15,
                     target: AnyObject? = nil,
                     selector: Selector? = nil,
                     events: UIControlEvents? = .touchUpInside,
                     image: String? = nil,
                     bgImage: String? = nil) {
        self.init()
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        
        if let fontSize = fontSize {
            self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
        
        if let target = target, let selector = selector {
            self.addTarget(target, action: selector, for: events!)
        }
        
        if let image = image {
            self.setImage(UIImage(named: "\(image)"), for: .normal)
            self.setImage(UIImage(named: "\(image)_highlighted"), for: .highlighted)
        }
        
        if let bgImage = bgImage {
            self.setBackgroundImage(UIImage(named: "\(bgImage)"), for: .normal)
            self.setBackgroundImage(UIImage(named: "\(bgImage)_highlighted"), for: .highlighted)
        }
        
        
        
    }
    
    
    
}
