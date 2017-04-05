//
//  WBWelcomeView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import SDWebImage

class WBWelcomeView: UIView {

    //头像
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: WBUserAccount.shared.avatar_large!)!, placeholderImage: UIImage(named: "avatar_default_big")!)
        return imageView
    }()

    //欢迎文字的label
    lazy var welcomeLabel: UILabel = UILabel(title: "欢迎归来, \(WBUserAccount.shared.screen_name!)", fontSize: 15, alignment: .center)
    
    //已经添加到视图
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        //添加动画
        addAnimation()
        
    }

    
    override init(frame: CGRect) {
        super.init(frame: screenBounds)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 创建 UI
extension WBWelcomeView {
    
    func setupUI() {
        
        self.backgroundColor = UIColor.white
        
        //0. 给头像设圆角
        iconView.layer.cornerRadius = 45
        iconView.layer.masksToBounds = true
        
        //1. 添加子视图
        addSubview(iconView)
        addSubview(welcomeLabel)
        
        //2. 自动布局
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-120)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-150)
        }

        
        //在动画执行之前，需要先强制执行布局 UI（执行 layoutIfNeeded），在这个方法调用之后，上面的布局才会生效
        layoutIfNeeded()
        
        
    }
    
    //添加动画
    func addAnimation() {
        
       //更新头像的约束
        iconView.snp.updateConstraints { (make) in
            make.centerY.equalTo(self).offset(-150)
        }
        
        //usingSpringWithDamping: 弹力系数, 越小越弹
        //initialSpringVelocity: 重力系数
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 9.8, options: [], animations: { 
            self.layoutIfNeeded()
        }) { (isFinish) in
            self.removeFromSuperview()
        }
        
        
    }
    
    
}

















