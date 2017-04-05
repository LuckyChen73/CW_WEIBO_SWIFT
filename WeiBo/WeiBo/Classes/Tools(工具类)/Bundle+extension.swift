//
//  Bundle+extension.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

let versionKey = "versionKey"

extension Bundle {

    var isNewFeature: Bool {
        //1.取到当前版本的值
        let newVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
        //2.取到老版本的值
        let oldVersion = UserDefaults.standard.value(forKey: versionKey) as? String
        
        //3.比较
        //如果没有保存过版本号, 或者当前的版本号与老版本不一至, 就明有新版本
        if oldVersion == nil || newVersion != oldVersion! {
            //把新版本号保存起来
            UserDefaults.standard.set(newVersion, forKey: versionKey)
            //isNewFeature
            return true
        }
        //isNewFeature 没有新特性
        return false
    }
    
  
}
