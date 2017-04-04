//
//  NetworkTool+Login.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/4.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

extension NetworkTool{

    /// 调用该方法获取 code api.weibo.com/oauth2/access_token?client_id
    ///
    /// - Parameters:
    ///   - code: 从 url 中截取字符串
    ///   - callBack: 完成回调
    func requestToken(code: String, callBack: @escaping (Any?)->()){
        
        let parameters = ["client_id": appKey,
                          "client_serect": appSecret,
                          "grant_type": "authorization_code",
                          "code": code,
                          "redirect_uri": redirectURL]
        
        requeset(url: "https://api.weibo.com/oauth2/access_token", method: "POST", parameters: parameters) { (response) in
            callBack(response)
        }
    }
    
    
    /// 获取用户信息
    ///
    /// - Parameters:
    ///   - uid: 用户 id
    ///   - accessToken: token
    ///   - callBack:  完成回调
    func requestUser(uid: String, accessToken: String, callBack: @escaping (Any?)->()) {
        
        let parameters = ["uid": uid,
                          "access_token": accessToken]
        requeset(url: "https://api.weibo.com/2/users/show.json", method: "GET", parameters: parameters) { (responseData) in
            callBack(responseData)
        }
        
    }
    
    
    
}
