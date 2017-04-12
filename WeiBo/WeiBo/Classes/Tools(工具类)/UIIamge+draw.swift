//
//  UIIamge+draw.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

extension UIImage {
    class func pureImage(color: UIColor = UIColor.white, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        //1. 开始图形上下文
        UIGraphicsBeginImageContext(size)
        
        //2. 设置颜色
        color.setFill()
        
        //3. 颜色填充
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        
        //4. 从图形上下文获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //5. 关闭图形上下文
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    //创建圆角图片
    func createCircleImage(color: UIColor = UIColor.white, size: CGSize = CGSize(width: 1, height: 1), callBack:@escaping (UIImage?)->()) {
        
        DispatchQueue.global().async {
            let rect = CGRect(origin: CGPoint.zero, size: size)
            
            //1. 开始图形上下文
            UIGraphicsBeginImageContext(size)
            
            //2. 设置颜色
            color.setFill()
            
            //3. 颜色填充
            UIRectFill(rect)
            
            //圆形裁切
            let path = UIBezierPath(ovalIn: rect)
            path.addClip()
            
            self.draw(in: rect)
            
            //4. 从图形上下文获取图片
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            //5. 关闭图形上下文
            UIGraphicsEndImageContext()
            
            //在主线程更新UI
            DispatchQueue.main.async {
                callBack(image)
            }
        }
    }


    
    /// 重设图片的大小
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小
    ///   - callBack: 完成回调
    func resizeImage(color: UIColor = UIColor.white, size: CGSize = CGSize(width: 1, height: 1), callBack:@escaping (UIImage?)->()) {
        
        DispatchQueue.global().async {
            let rect = CGRect(origin: CGPoint.zero, size: size)
            
            //1. 开始图形上下文
            UIGraphicsBeginImageContext(size)
            
            //2. 设置颜色
            color.setFill()
            
            //3. 颜色填充
            UIRectFill(rect)
            
            self.draw(in: rect)
            
            //4. 从图形上下文获取图片
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            //5. 关闭图形上下文
            UIGraphicsEndImageContext()
            
            //在主线程更新UI
            DispatchQueue.main.async {
                callBack(image)
            }
        }
    }
    
    
}
