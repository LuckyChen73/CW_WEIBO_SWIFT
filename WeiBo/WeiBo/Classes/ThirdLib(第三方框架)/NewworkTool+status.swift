//
//  NewworkTool+status.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

extension NetworkTool {

    /// 获取微博的首页数据
    ///
    /// - Parameters:
    ///   - sinceId: 返回比微博 id 大的微博数据
    ///   - maxId: 返回等于或小于当前微博 id 的微博数据
    ///   - callBack: 完成回调
    func requsetStatus(sinceId: Int64 = 0, maxId: Int64 = 0, callBack: @escaping (Any?)->()) {
        
        //获取 url
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        //创建请求参数
        let parameters: [String: Any] = ["access_token": WBUserAccount.shared.access_token!, "since_id": sinceId, "max_id": maxId]
        
        self.get(urlStr, parameters: parameters, progress: nil, success: { (_, response) in
            
            //response是一个可选的 Any 类型，先将其弱转（a？）成字典，得到一个可选字典，再对其可选绑定
            if let response = response as? [String: Any], //从字典中取出字典 statuses 对应的值，这个值取到是一个可选的Any 类型的值，再进行弱转，得到字典数组，再做可选绑定
            let statusArr = response["statuses"] as? [[String: Any]]{
                //此时statusArr是一个必选的数组
                //字典数组转模型数组,再对其弱转成[WBStatusModel],再做可选绑定
                if let statusModelArr = NSArray.yy_modelArray(with: WBStatusModel.self, json: statusArr){
                    //模型回调
                callBack(statusModelArr)
                
                }else {
                    callBack(nil)
                }
            }
        }) { (_, error) in
            print(error)
            callBack(nil)
        }
        
        
        
        
        
    }
    
    
    
    
    
    
}
