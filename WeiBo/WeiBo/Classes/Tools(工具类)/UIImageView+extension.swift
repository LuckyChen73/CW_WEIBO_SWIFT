//
//  UIImageView+extension.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

extension UIImageView {

    convenience init(imageName: String){
        self.init()
        
        let image = UIImage(named: imageName)
        
        self.image = image
    }

}
