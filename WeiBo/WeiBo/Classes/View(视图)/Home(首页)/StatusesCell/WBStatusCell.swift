//
//  WBStatusCell.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit



class WBStatusCell: UITableViewCell {
    //模型数据赋值
    var statusViewModel: WBStatusViewModel? {
        didSet{
            originalStatusView.statusViewModel = statusViewModel
        }
        
    }
    
    
    /// 原创微博部分
    lazy var originalStatusView: WBOriginalStatusView = WBOriginalStatusView()
    
    /// 转发微博部分
    lazy var retweetedStatusView: WBRetweetedStatusView = WBRetweetedStatusView()
    
    //cell底部 tabbar
    lazy var statusToolBar: WBStatusToolBar = WBStatusToolBar()
    
  
    
    //重写指定构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


// MARK: - 创建 UI
extension WBStatusCell {
    
    func setupUI() {
        
        //添加到 cell
        self.contentView.addSubview(originalStatusView)
//        self.contentView.addSubview(retweetedStatusView)
//        self.contentView.addSubview(statusToolBar)
        
        
        retweetedStatusView.backgroundColor = UIColor.yellow
        statusToolBar.backgroundColor = UIColor.brown
        
        //布局
        originalStatusView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
//            make.height.equalTo(50)
            make.bottom.equalTo(self.contentView)
        }
        
//        retweetedStatusView.snp.makeConstraints { (make) in
//            make.left.right.equalTo(self.contentView)
//            make.top.equalTo(originalStatusView.snp.bottom)
//            make.height.equalTo(80)
//            make.bottom.equalTo(self.contentView)
//        }
        
//        statusToolBar.snp.makeConstraints { (make) in
//            make.left.right.equalTo(self.contentView)
//            make.top.equalTo(retweetedStatusView.snp.bottom)
//            make.height.equalTo(36)
//            make.bottom.equalTo(self.contentView)
//        }
     

        
    }
    
}











