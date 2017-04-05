//
//  WBStatusModel.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBStatusModel: NSObject {

    /// 微博发布时间
    var created_at: String?
    /// 微博的id
    var id: String?
    /// 微博的来源
    var source: String?
    /// 微博的正文
    var text: String?
    /// 微博的图片
    var pic_urls: [WBPictureModel]?
    /// 发微博的用户
    var user: WBUserModel?
    /// 转发微博的数据
    var retweeted_status: WBStatusModel?
    
    /// 模型的描述信息
    override var description: String {
        return self.yy_modelDescription()
    }

    
    
    
 
}
