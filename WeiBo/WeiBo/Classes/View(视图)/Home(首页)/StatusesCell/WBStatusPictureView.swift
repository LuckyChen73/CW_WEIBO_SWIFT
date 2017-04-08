//
//  WBStatusPictureView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

let baseTag = 888888

class WBStatusPictureView: UIView {

    //接收传过来的statusViewModel模型数据
    var statusViewModel: WBStatusViewModel? {
        didSet{
            //先把所有的配图隐藏
            for i in 0..<9 {
                // self.viewWithTag(i + baseTag)通过这个属性和下标取到对应的子视图
                let imageView = self.viewWithTag(i + baseTag)
                imageView?.isHidden = true
            }
            
            //如果有图片
            if let pic_urls = statusViewModel?.pic_urls, pic_urls.count > 0 {
                
                var index = 0
                
                for _ in pic_urls { // _ pictureModel
                    let imageView = self.viewWithTag(index + baseTag)
                    imageView?.isHidden = false
                
                    index += 1
                }
            }
            
            
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 创建 UI
extension WBStatusPictureView {
    
    func setupUI() {
        self.backgroundColor = UIColor.yellow
        
        //裁剪超出配图部分
        self.clipsToBounds = true
        
        //imageView 的宽高
        let imageWH = (screenWidh - 40) / 3
        
        //移动一次就要调整 imageview 的 frame(水平和垂直的距离)
        let gap =  imageWH + 10
        
        let firstImageViewFrame = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
        //创建9个 imageView
        for i in 0..<9 {
            //创建
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.red
            
            imageView.tag = i + baseTag
            
            //计算行数和列数
            let row = i / 3
            let col = i % 3
            
            //计算 frame
            imageView.frame = firstImageViewFrame.offsetBy(dx: CGFloat(row) * gap, dy: CGFloat(col) * gap)
            
            addSubview(imageView)
        }
        
        
        
        
        
    }
    
    
    
}











