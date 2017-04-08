//
//  WBStatusPictureView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {

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
            
            //计算行数和列数
            let row = i / 3
            let col = i % 3
            
            //计算 frame
            imageView.frame = firstImageViewFrame.offsetBy(dx: CGFloat(row) * gap, dy: CGFloat(col) * gap)
            
            addSubview(imageView)
        }
        
        
        
        
        
    }
    
    
    
}











