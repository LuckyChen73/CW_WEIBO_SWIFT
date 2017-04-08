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
            statusLabel.text = statusViewModel?.statusModel.retweeted_status?.text

        }
    }

    
    //添加一个微博正文的label
    lazy var statusLabel: UILabel = UILabel(title: nil)
    
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
        addSubview(statusLabel)
        addSubview(statusPictureView)
        
        
        statusLabel.numberOfLines = 0
        statusLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
//            make.bottom.equalTo(self).offset(-10)
        }
        
        statusPictureView.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
            make.left.equalTo(self).offset(10)
            make.size.equalTo(CGSize(width: screenWidh, height: 150))
            make.bottom.equalTo(self).offset(-10)
        }
        
        
        
    }
    
    
    
}

