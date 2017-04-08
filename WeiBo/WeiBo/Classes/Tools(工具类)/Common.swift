//
//  Common.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/4.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit


//MARK: - 登录相关
let appKey = "2733110831"
let appSecret = "4b054ea7bfd1d91db3ae435f2a3fcd9a"
let redirectURL = "http://www.baidu.com"

let wbUserName = "BEACUSEYOU50405"
//qq登录


//MARK: - 和rect相关
let screenBounds = UIScreen.main.bounds
let screenWidh = screenBounds.width
let screenHeight = screenBounds.height
let screenScale = UIScreen.main.scale //缩放比例

//MARK: - UI相关
let globalColor: UIColor = UIColor.orange


//MARK: - 通知
//登录成功通知
let loginSuccessNotification = Notification.Name(rawValue: "loginSuccessNotification")

let pictureViewClickedNotification = Notification.Name(rawValue: "pictureViewClickedNotification")








