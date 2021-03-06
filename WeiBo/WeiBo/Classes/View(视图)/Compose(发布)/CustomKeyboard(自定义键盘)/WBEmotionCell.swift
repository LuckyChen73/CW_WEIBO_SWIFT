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
                    
                    //判断表情的类型
                    if let imageName = emotionModel.fullPngPath {
                        let image = UIImage(named: imageName)
                        button.setImage(image, for: .normal)
                        button.setImage(image, for: .highlighted)
                        button.setTitle(nil, for: .normal)
                        button.setTitle(nil, for: .highlighted)
                    } else {
                        //把十六进制数转成字符串
                        let emoji = NSString.emoji(withStringCode: emotionModel.code!)
                        button.setTitle(emoji, for: .normal)
                        button.setTitle(emoji, for: .highlighted)
                        button.setImage(nil, for: .normal)
                        button.setImage(nil, for: .highlighted)
                    }
       
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
            
            let button = UIButton(title: nil, fontSize: 34, target: self, selector: #selector(emotionClicked(button:)), image: image)
        
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
        //获取到被点击的表情的按钮的tag
        let tag = button.tag - baseTag
        
        //是否是插入操作
        var isInsert = true
        
        //是否是删除操作, 如果是删除操作, 传递一个action, 告诉接收者是删除事件
        if tag == 20 {
            print("删除")
            isInsert = false
            let userInfo: [String: Any] = ["action": isInsert]
            let notification = Notification(name: emotionButtonClickedNotification, object: nil, userInfo: userInfo)
            NotificationCenter.default.post(notification)
        } else {
            print("输入")
            //如果是插入操作,将需要插入的表情模型传出
            let emotionModel = emotions?[tag]
            //将表情和插入操作一起作为字典参数传过去
            let userInfo: [String: Any] = ["emotion": emotionModel!, "action": isInsert]
            let notification = Notification(name: emotionButtonClickedNotification, object: nil, userInfo: userInfo)
            NotificationCenter.default.post(notification)
            
        }
        
        
    }
    
    
}


