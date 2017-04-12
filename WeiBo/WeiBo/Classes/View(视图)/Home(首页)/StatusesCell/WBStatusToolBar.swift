//
//  WBStatusToolBar.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {
    
    /// 转发的button
    lazy var retweetButton: UIButton = UIButton(title: "30", titleColor: UIColor.lightGray, fontSize: 11, image: "timeline_icon_retweet")
    
    /// 评论的button
    lazy var commentButton: UIButton = UIButton(title: "30", titleColor: UIColor.lightGray, fontSize: 11, image: "timeline_icon_comment")
    
    /// 赞的button
    lazy var prizeButton: UIButton = UIButton(title: "30", titleColor: UIColor.lightGray, fontSize: 11, image: "timeline_icon_unlike")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 点击事件
extension WBStatusToolBar {
    
    func retweeted(button: UIButton) {
//        print("转发微博")
    }
}


// MARK: - 创建 UI
extension WBStatusToolBar {
    
    func setupUI() {
        
        //添加三个按钮
        self.backgroundColor = UIColor(patternImage: UIImage(named: "timeline_card_bottom_background")!)
        
        //1. 添加子控件
        addSubview(retweetButton)
        addSubview(commentButton)
        addSubview(prizeButton)
        
        //2. 自动布局
        retweetButton.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        commentButton.snp.makeConstraints { (make) in
            make.left.equalTo(retweetButton.snp.right)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(retweetButton)
        }
        
        prizeButton.snp.makeConstraints { (make) in
            make.left.equalTo(commentButton.snp.right)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
            make.width.equalTo(commentButton)
        }
        
        
    }
    
    
}





