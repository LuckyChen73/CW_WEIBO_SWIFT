//
//  WBRetweetedStatusView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import SDWebImage

class WBRetweetedStatusView: UIView {
    //真实数据赋值
    var statusViewModel: WBStatusViewModel? {
        didSet{
            retweetedStatusLabel.text = statusViewModel?.statusModel.retweeted_status?.text

            //判断是否有配图，决定是否需要显示配图
            if let count = statusViewModel?.statusModel.retweeted_status?.pic_urls?.count, count > 0 {
                //有配图，更新配图的约束
                statusPictureView.snp.updateConstraints({ (make) in
                    make.top.equalTo(retweetedStatusLabel.snp.bottom).offset(10)
                    make.height.equalTo(150)
                })
                
            }else {
                //没有配图
                statusPictureView.snp.updateConstraints({ (make) in
                    make.top.equalTo(retweetedStatusLabel.snp.bottom)
                    make.height.equalTo(0)
                })
            }

        }
    }

    
    //添加一个微博正文的label
    lazy var retweetedStatusLabel: UILabel = UILabel(title: nil)
    
    //添加配图视图
    let statusPictureView: WBStatusPictureView = WBStatusPictureView()
    
    
    /// 构造方法
    ///
    /// - Parameter frame:  frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


// MARK: - 创建 UI
extension WBRetweetedStatusView {
    
    func setupUI() {
        
        //1.添加子控件
        addSubview(retweetedStatusLabel)
        addSubview(statusPictureView)
        
        
        retweetedStatusLabel.numberOfLines = 0
        retweetedStatusLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        statusPictureView.snp.makeConstraints { (make) in
           make.top.equalTo(retweetedStatusLabel.snp.bottom).offset(10)
            make.left.equalTo(retweetedStatusLabel)
            make.size.equalTo(200)
            make.bottom.equalTo(self).offset(-10)
        }
        
        
        
    }
    
    
    
}

