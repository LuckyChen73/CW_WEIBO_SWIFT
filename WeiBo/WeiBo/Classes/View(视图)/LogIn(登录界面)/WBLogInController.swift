//
//  WBLogInController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/4.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBLogInController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建 UI
        setupUI()
    }
    
    
   

}


// MARK: - 创建 UI
extension WBLogInController {
    
    /// 创建 UI
    func setupUI() {
        self.view.backgroundColor = UIColor.yellow
        
        //添加返回按钮
        let backBtnItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        
        self.navigationItem.leftBarButtonItem = backBtnItem
    }
    
}


// MARK: - 点击事件
extension WBLogInController {
    
    func back() {
        //自己消失
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}













