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
    }



}


extension WBRootController {
    
    func setupUI() {
    
        setupVisitorView()
        
    }
    
    func setupVisitorView() {
        
        //创建访客视图并设置大小
        visitorView = WBVisitorView(frame: self.view.bounds)
        
        //给访客视图的文本，图标信息赋值
        //visitorInfo 可空链式调用，如果前面有值，调用后面属性就有效果，反之
        visitorView?.visitorInfo = self.visitorDic
        
         self.view.addSubview(visitorView!)
        
    }
    
    
    
}


