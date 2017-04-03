//
//  WBVisitorView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

/*
 自定义子视图的套路
 1. 创建一个子视图的文件, 让它继承UIView
 2. 重写init方法
 3. 创建setupUI的方法, 并在init方法调用
 4. 创建子控件的属性
 5. 在setupUI的方法中, 添加控件, 设置控件, 自动布局
 */

class WBVisitorView: UIView {

    //大图标
    lazy var iconImageView: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_house")
    
    //外部环形图
    lazy var circleImageView: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_smallicon")

    //遮罩视图
    lazy var coverImageView: UIImageView = UIImageView(imageName: "visitordiscover_feed_mask_smallicon")

    //文字
    lazy var textLab: UILabel = UILabel(title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", titleColor: UIColor.lightGray, fontSize: 14, alignment: .center, numOflines: 0)

    //注册按钮
    lazy var signupButton: UIButton = UIButton(title: "注册", target: self, selector: #selector(signUpButton(button:)), events: UIControlEvents.touchUpInside, bgImage: "common_button_white_disable")
    
    //登录按钮
    lazy var logInButton: UIButton = UIButton(title: "登录", target: self, selector: #selector(logInButton(button:)), events: UIControlEvents.touchUpInside, bgImage: "common_button_white_disable")
    
    
    //构造函数，重写 init 方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建 UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - 点击事件
extension WBVisitorView {
    
    //注册
    func signUpButton(button: UIButton) {
        
        print("注册")
    }
    
    //登录
    func logInButton(button: UIButton) {
        
        print(" 登录")
    }
    
}


// MARK: - 创建 UI
extension WBVisitorView {
    //布局
    func setupUI() {
        self.backgroundColor = UIColor.rgbColor(r: 237, g: 237, b: 237)
        
        self.addSubview(iconImageView)
        self.addSubview(circleImageView)
        self.addSubview(coverImageView)
        self.addSubview(textLab)
        self.addSubview(signupButton)
        self.addSubview(logInButton)
        
        
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-120)
        }
        
        circleImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImageView.snp.centerX)
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
        
        
        coverImageView.snp.makeConstraints { (make) in
            make.top.equalTo(circleImageView.snp.bottom).offset(-100)
            make.left.right.equalTo(self)
            make.height.equalTo(120)
        }
        
        textLab.snp.makeConstraints { (make) in
            make.top.equalTo(coverImageView.snp.bottom).offset(60)
            make.left.equalTo(self).offset(60)
            make.right.equalTo(self).offset(-60)
        }
        
        signupButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(80)
            make.bottom.equalTo(self).offset(-130)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        logInButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-80)
            make.bottom.equalTo(self).offset(-130)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        
    }
    
    
}





