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
    func updateStatus(status: String, callBack: @escaping (Any?)->()) {
        let url = "https://api.weibo.com/2/statuses/update.json"
        let parameters = ["access_token": (WBUserAccount.shared.access_token)!, "status": status]
        
        // 调用网络中间层的接口发布微博
        self.requeset(url: url, method: "POST", parameters: parameters) { (response) in
            callBack(response)
        }
        
    }
    
}
