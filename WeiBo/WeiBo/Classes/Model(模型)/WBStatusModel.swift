//
//  WBStatusModel.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import YYModel

class WBStatusModel: NSObject {

    /// 微博发布时间
    var created_at: String?
    /// 微博的id
    var id: Int64 = 0
    /// 微博的来源
    var source: String?
    /// 微博的正文
    var text: String?
    /// 微博的图片
    var pic_urls: [WBPictureModel]? //在 YYModel 中被定义为容器属性的类
    /// 发微博的用户
    var user: WBUserModel?
    /// 转发微博的数据
    var retweeted_status: WBStatusModel?
    
    /// 模型的描述信息
    override var description: String {
        return self.yy_modelDescription()
    }
    
    //当返回的模型的字典中有数组, 而数组中又放了字典, 并且需要将该字典转模型, 就需要指定一下该数组中的在字典对应的什么模型
    ///  类方法模型容器属性
    ///
    /// - Returns: 返回包着图片模型的容器字典
    class func modelContainerPropertyGenericClass() -> [String: Any] {
        return ["pic_urls": WBPictureModel.self]
    }
 
}
