//
//  WBRootController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBRootController: UIViewController {

    var visitorView: WBVisitorView?
    
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
        
         self.view.addSubview(visitorView!)
        
    }
    
    
    
}


