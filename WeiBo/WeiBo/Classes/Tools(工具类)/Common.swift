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

//点击配图视图的单张图片的通知
let pictureViewClickedNotification = Notification.Name(rawValue: "pictureViewClickedNotification")

//点击表情键盘的按钮的通知
let emotionButtonClickedNotification = Notification.Name(rawValue: "emotionButtonClickedNotification")


//MARK: - 延迟执行的全局的方法

/// 延迟执行的方法
///
/// - Parameters:
///   - seconds: 秒数
///   - afterToDo: 需要延迟执行的闭包(就是需要延迟执行的那件事)
func after(_ seconds: Int, _ afterToDo: @escaping ()->()) {
    let deadlineTime = DispatchTime.now() + .seconds(seconds)
    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
        afterToDo()
    }
}





