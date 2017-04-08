//
//  UIImageView+extension.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {

    convenience init(imageName: String){
        self.init()
        
        let image = UIImage(named: imageName)
        
        self.image = image
        
    }
    
    
    
    
    /// 网络图片的中间层
    ///
    /// - Parameters:
    ///   - urlStr:  url 字符串
    ///   - placeHolderImage: 占位图
    func wb_setImage(urlStr: String, placeHolderImage: String) {
        
        let url = URL(string: urlStr)
        let placeHoldImage = UIImage(named: placeHolderImage)
        
        if let url = url, let placeHoldImage = placeHoldImage {
            
             self.sd_setImage(with: url, placeholderImage: placeHoldImage)
        }
        
    }
    
    
    
    
    
    

}
