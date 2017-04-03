//
//  UIlabel+convenience.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

extension UILabel {

    convenience init(title: String?,
                     titleColor: UIColor? = .darkGray,
                     fontSize: CGFloat? = 15,
                     alignment: NSTextAlignment? = .left,
                     numOflines: Int? = 1){
        self.init()
        
        self.text = title
        self.textColor = titleColor
        self.font = UIFont.systemFont(ofSize: fontSize!)
        self.textAlignment = alignment!
        self.numberOfLines = numOflines!
        
    }
}
