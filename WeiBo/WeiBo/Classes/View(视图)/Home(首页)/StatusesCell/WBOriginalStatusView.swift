//
//  WBOriginalStatusView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import SDWebImage

class WBOriginalStatusView: UIView {
    //真实数据赋值
    var statusViewModel: WBStatusViewModel? {
        didSet{
            let url = URL(string: (statusViewModel?.statusModel.user?.avatar_large)!)
            //头像
            userIcon.sd_setImage(with: url!, placeholderImage: UIImage(named: "avatar_default_big"))
            //昵称
            userNameLable.text = statusViewModel?.statusModel.user?.screen_name
            //微博正文
            statusLabel.text = statusViewModel?.statusModel.text
            
            //来源
            sourceLable.text = statusViewModel?.sourceStr
            
            //vip 图标
            vipIcon.image = statusViewModel?.vipImage
            
            //皇冠
            levelIcon.image = statusViewModel?.levelImage
            
            //微博发布时间
            timeLable.text = statusViewModel?.timeStr
         
            //处理用户头像
            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil) { (image, _, _, _, _) in
                image?.createCircleImage(size: CGSize(width: 35, height: 35), callBack: { (circleImage) in
                    self.userIcon.image = circleImage
                })
            }
        }
    }
    
    
    /// 用户头像
    lazy var userIcon: UIImageView = UIImageView(imageName: "avatar_default_big")
    
    /// 用户的vip图标
    lazy var vipIcon: UIImageView = UIImageView(imageName: "avatar_grassroot")
    
    /// 用户的昵称
    lazy var userNameLable: UILabel = UILabel(title: "小王爱睡觉")
    
    /// 用户的皇冠的等级图标
    lazy var levelIcon: UIImageView = UIImageView(imageName: "common_icon_membership_level6")
    
    /// 微博的来源
    lazy var sourceLable: UILabel = UILabel(title: "新浪", titleColor: UIColor.lightGray, fontSize: 12)
    /// 微博的发布时间
    lazy var timeLable: UILabel = UILabel(title: "两小时前", titleColor: UIColor.lightGray, fontSize: 12)
    
    //添加一个微博正文的label
    lazy var statusLabel: UILabel = UILabel(title: nil)
    
    //添加配图视图
    let statusPictureView: WBStatusPictureView = WBStatusPictureView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


extension WBOriginalStatusView {
    
    func setupUI() {
        
        //1.添加子控件
        addSubview(userIcon)
        addSubview(vipIcon)
        addSubview(userNameLable)
        addSubview(levelIcon)
        addSubview(sourceLable)
        addSubview(timeLable)
        addSubview(statusLabel)
        addSubview(statusPictureView)
        
        
        //2. 自动布局(自上而下, 从左到右, 依次布局, 当子控件较多时, 添加一两个就要测试)
        userIcon.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        vipIcon.snp.makeConstraints { (make) in
            make.left.equalTo(userIcon.snp.right).offset(-10)
            make.top.equalTo(userIcon.snp.bottom).offset(-10)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        userNameLable.snp.makeConstraints { (make) in
            make.left.equalTo(userIcon.snp.right).offset(10)
            make.top.equalTo(userIcon)
        }
        
        levelIcon.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLable.snp.right).offset(10)
            make.bottom.equalTo(userNameLable).offset(-3)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        timeLable.snp.makeConstraints { (make) in
            make.left.equalTo(userIcon.snp.right).offset(10)
            make.bottom.equalTo(userIcon)
        }
        
        sourceLable.snp.makeConstraints { (make) in
            make.left.equalTo(timeLable.snp.right).offset(10)
            make.bottom.equalTo(userIcon)
        }
        
        statusLabel.numberOfLines = 0
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userIcon.snp.bottom).offset(10)
            make.left.equalTo(userIcon)
            make.right.equalTo(self).offset(-10)
//            make.bottom.equalTo(self).offset(-10)
        }
    
        statusPictureView.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(150)
            make.bottom.equalTo(self).offset(-10)
        }
        
        
        
        
    }
    
    
    
}















