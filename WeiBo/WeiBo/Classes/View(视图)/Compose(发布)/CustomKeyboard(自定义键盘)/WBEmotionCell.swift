//
//  WBEmotionCell.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/14.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

fileprivate let baseTag = 88

class WBEmotionCell: UICollectionViewCell {
    
    var emotions: [WBEmotionModel]? {
        didSet{
            if let emotions = emotions {
                //先把所有的篮子都隐藏
                for i in 0..<20 {
                    let button = self.contentView.viewWithTag(i + baseTag)
                    button?.isHidden = true
                }
            
                //再遍历萝卜找篮子
                for (index, emotionModel) in emotions.enumerated() {
                    let button = self.contentView.viewWithTag(index + baseTag) as! UIButton
                    button.isHidden = false
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

// MARK: - UI 搭建
extension WBEmotionCell {
    func setupUI() {
        
        //1. 创建二十一个button
        let buttonWH = screenWidh/7
        let firstRect = CGRect(x: 0, y: 0, width: buttonWH, height: buttonWH)
        for i in 0..<21 {
            var image: String?
            
            //最后一个 button，是删除
            if i == 20 {
                image = "compose_emotion_delete"
            }
            
            let button = UIButton(title: nil, target: self, selector: #selector(emotionClicked(button:)), image: image)
            button.backgroundColor = UIColor.randomColor()
            button.tag = i + baseTag
            
            let row = i / 7 //行数
            let col = i % 7 //列数
            
            let frame = firstRect.offsetBy(dx: CGFloat(col)*buttonWH, dy: CGFloat(row)*buttonWH)
            
            button.frame = frame
            self.contentView.addSubview(button)
        }
        
        
    }
    

}

// MARK: - 点击事件的处理
extension WBEmotionCell {
    
    func emotionClicked(button: UIButton) {
        
        let tag = button.tag - baseTag
        
        if tag == 20 {
            print("删除")
        } else {
            print("输入")
        }
        
        
    }
    
    
}


