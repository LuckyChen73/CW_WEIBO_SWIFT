//
//  UILabel+extension.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/15.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(title: String?,
                     textColor: UIColor = UIColor.darkGray,
                     fontSize: CGFloat = 14,
                     numOfLines: Int = 0,
                     alignment: NSTextAlignment = .left) {
        self.init()
        
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.numberOfLines = numOfLines
        self.textAlignment = alignment
        
        self.sizeToFit()
    }
    
}

// MARK: - FFLabel
extension FFLabel {
    convenience init(title: String?,
                     textColor: UIColor = UIColor.darkGray,
                     fontSize: CGFloat = 14,
                     numOfLines: Int = 0,
                     alignment: NSTextAlignment = .left) {
        self.init()
        
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.numberOfLines = numOfLines
        self.textAlignment = alignment
        
        self.sizeToFit()
    }
}



