//
//  WBUserCount.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/4.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

let userAccountKey: String = "userAccountKey"

class WBUserAccount: NSObject {

    /// 单例
    static let shared = WBUserAccount()
    
    /// token
    var access_token: String?
    
    /// 过期秒数
    var expire_in: Double = 0 {
        didSet{
            expires_date = Date(timeIntervalSinceNow: expire_in)
        }
    }
    
    /// 过期的日期
    var expires_date: Date?
    
    /// 用户 id
    var uid: String?
    
    /// 用户的昵称
    var screen_name: String?
    
    /// 用户头像地址
    var avatar_large: String?
    
    //重写 init 方法
    // override 对应的 super     convenience 对应的 self
    override init(){
        super.init()
        
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    /// 用户是否登录
    var isLogIn: Bool{
        //access_token != nil  access_token没有过期
//        return access_token != nil && Date().timeIntervalSince(expires_date!) < 0 //token不等于 nil，并且过期日期到现在时间的差值小于0，小于0说明没有过期
        
        //token 不等于 nil，并且当前日期与过期日期比较，结果为升序
        return access_token != nil && Date().compare(expires_date!) == .orderedAscending
    }
    
    //保存用户信息
    func save(dict: [String: Any]) {
        //先给对象的属性赋值
        setValuesForKeys(dict)
        //将模型转成字典
        let userDic = dictionaryWithValues(forKeys: ["access_token", "uid", "screen_name", "avatar_large"])
        //保存字典
        UserDefaults.standard.set(userDic, forKey: userAccountKey)
        
    }
    
    func read() {
        //先从UserDefaults中取出字典
        if let userDic = UserDefaults.standard.value(forKey: userAccountKey) as? [String: Any]{
            //再保存字典
            setValuesForKeys(userDic) //这样就过滤了不必要的信息
        }
    }
    
}
