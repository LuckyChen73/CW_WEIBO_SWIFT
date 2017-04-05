//
//  WBRootController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBRootController: UIViewController {
    //访客视图
    var visitorView: WBVisitorView?
    
    //访客视图的文本，图标信息
    var visitorDic: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        //接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: loginSuccessNotification, object: self)
    }

    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    

}


// MARK: - 创建 UI
extension WBRootController {
    
    func setupUI() {
    
        setupVisitorView()
        
    }
    
    func setupVisitorView() {
        
        //创建访客视图并设置大小
        visitorView = WBVisitorView(frame: self.view.bounds)
        
        //设置代理
        visitorView?.delegate = self
        
        //给访客视图的文本，图标信息赋值
        //visitorInfo 可空链式调用，如果前面有值，调用后面属性就有效果，反之
        visitorView?.visitorInfo = self.visitorDic
        
         self.view.addSubview(visitorView!)
        
    }

}


// MARK: - 代理方法
extension WBRootController: WBVisitorViewDelegate {
    //实现代理方法
    func logIn() {
        //点击登录按钮后，跳转到登录控制器
        let wbLoginVC = WBLogInController()
        let navLoginVC = UINavigationController(rootViewController: wbLoginVC)
        present(navLoginVC, animated: true, completion: nil)
        
    }
    
    
}


// MARK: - 接收通知
extension WBRootController {
    //接收通知后的事件
    func loginSuccess() {
        
         print("你好")
        
    }
    
    
}





