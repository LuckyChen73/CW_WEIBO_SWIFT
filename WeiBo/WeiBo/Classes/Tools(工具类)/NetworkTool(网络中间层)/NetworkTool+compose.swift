//
//  WB.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/12.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

extension NetworkTool {

    /// 发布文本微博的借口封装
    ///
    /// - Parameters:
    ///   - status: 微博文字
    ///   - callBack: 完成回调
    func updateStatus(status: String,imageData: Data?, callBack: @escaping (Any?)->()) {
        if let imageData = imageData {
            //上传接口
            let url = "https://upload.api.weibo.com/2/statuses/upload.json"
            let parameters = ["access_token": (WBUserAccount.shared.access_token)!, "status": status]
            
            // 调用网络中间层的接口发布微博
            self.upload(url: url, parameters: parameters, data: imageData, name: "pic", fileName: "abc.png", callBack: { (response) in
                callBack(response)
            })
        }else {
            
            let url = "https://api.weibo.com/2/statuses/update.json"
            let parameters = ["access_token": (WBUserAccount.shared.access_token)!, "status": status]
            
            // 调用网络中间层的接口发布微博
            self.requeset(url: url, method: "POST", parameters: parameters, callBack: { (response) in
                callBack(response)
            })
        }
        
        
        
    }
    
}
