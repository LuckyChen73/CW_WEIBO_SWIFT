//
//  WBStatusViewModel.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/6.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBStatusViewModel: NSObject {
    /// statusModel
    var statusModel: WBStatusModel
    
    /// 处理过的来源字符串
    var sourceStr: String?
    
    /// 处理过的vip等级的图片
    var vipImage: UIImage?
    
    /// 处理过的皇冠等级的图片
    var levelImage: UIImage?
    
    /// 处理过的来源字符串
    var timeStr: String?

    //构造函数，viewModel创建时，就将函数中的事件处理完
    init(statusModel: WBStatusModel) {
        self.statusModel = statusModel
        super.init()
        
        //来源处理
        dealWithSource()
        //vip等级处理
        dealWithVipIcon()
        //皇冠等级处理
        dealWithLevelIcon()
        //时间处理
        dealWithTime()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    /// 将服务器返回的来源字符串, 处理成需求的来源字符串
    func dealWithSource() {
        //"<a href=\"http://weibo.com/\" rel=\"nofollow\">iPhone 7 Plus</a>"
        if let source = statusModel.source, source.characters.count > 0 {
            let starIndex = source.range(of: "\">")?.upperBound
            let endIndex = source.range(of: "</a>")?.lowerBound
            
            let range = starIndex!..<endIndex!
            sourceStr = source.substring(with: range)
        }
    }
    
    /// 处理vip的等级的图标
    func dealWithVipIcon () {
        //用户vip的信息: 0代表达人, 2, 3, 5代表企业达人, 220代表草根达人
        if let vip = statusModel.user?.verified_type {
            switch vip {
            case 0:
                vipImage = UIImage(named: "avatar_vip")
            case 2, 3, 5:
                vipImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                vipImage = UIImage(named: "avatar_grassroot")
            default:
                vipImage = nil
            }
        }
    }
    
    /// 处理皇冠等级的图标
    func dealWithLevelIcon() {
        //用户的皇冠的等级 从1到6
        if let mbrank = statusModel.user?.mbrank, mbrank > 0 && mbrank < 7 {
            levelImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
    }
    
    /// 处理时间的字符串
    func dealWithTime() {
        if let sinaTime = statusModel.created_at {
            //timeStr = Date.sinaTimeToDate(sinaTime: sinaTime).dateToRequiredTimeStr()
            timeStr = Date.requiredTimeStr(sinaTime: sinaTime)
        }
    }

    
    
}
