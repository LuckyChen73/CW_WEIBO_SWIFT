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
        self.selectionStyle = .none
        
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
            make.top.equalTo(self.contentView).offset(5)
            make.left.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
        }
        
        retweetedStatusView.snp.makeConstraints { (make) in
            make.top.equalTo(originalStatusView.snp.bottom)
            make.left.right.equalTo(self.contentView)
            
        }
        
        /// .priority(800) 解决报约束冲突的问题
        statusToolBar.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.top.equalTo(retweetedStatusView.snp.bottom)
            make.height.equalTo(36)
            make.bottom.equalTo(self.contentView).priority(800)
        }
        
        
        // 离屏渲染 - 异步绘制
        self.layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质上滚动的是这张图片
        // cell 优化，要尽量减少图层的数量，相当于就只有一层！
        // 停止滚动之后，可以接收监听
        self.layer.shouldRasterize = true
        
        // 使用 `栅格化` 必须注意指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale

        
    }
    
}
