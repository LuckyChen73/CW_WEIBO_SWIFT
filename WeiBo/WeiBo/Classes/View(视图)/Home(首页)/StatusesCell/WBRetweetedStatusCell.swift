//
//  WBRetweetedStatusCell.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/7.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBRetweetedStatusCell: UITableViewCell {

    //模型数据赋值
    var statusViewModel: WBStatusViewModel? {
        didSet{
            originalStatusView.statusViewModel = statusViewModel
            retweetedStatusView.statusViewModel = statusViewModel
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
extension WBRetweetedStatusCell {
    
    func setupUI() {
        
        //添加到 cell
        self.contentView.addSubview(originalStatusView)
        self.contentView.addSubview(retweetedStatusView)
        self.contentView.addSubview(statusToolBar)
        
        
        retweetedStatusView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        //布局
        originalStatusView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
        }
        
        retweetedStatusView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(originalStatusView.snp.bottom)
        }
        
        /// .priority(800) 解决报约束冲突的问题
        statusToolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView).priority(800)
            make.top.equalTo(retweetedStatusView.snp.bottom)
            make.height.equalTo(36)
        }
        

        
    }
    
}
