//
//  WBMainController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBMainController: WBRootController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //创建及设置 UI
        setupUI()
        
    }

   

}


// MARK: - 点击事件
extension WBMainController {
    
    
    
    
}




// MARK: - 创建 UI
extension WBMainController {
    
    //创建 UI
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        //添加子控制器
        addChildVC()
        
        
        
    }
    
    
    //添加子控制器
    func addChildVC() {
        //解析 json 文件
        if let url = Bundle.main.url(forResource: "main.json", withExtension: nil), let object = try? Data(contentsOf: url), let dictArr = try? JSONSerialization.jsonObject(with: object, options: []) as! [[String: Any]] {
            
            var viewControllers: [UINavigationController] = []
            for dict in dictArr {
                
                if let nav = generateSingleVC(dict: dict) {
                
                    viewControllers.append(nav)
                }
            }
            
            self.viewControllers = viewControllers
        }
        
    }
    
    //创建单个子控制器
    func generateSingleVC(dict: [String: Any]) -> UINavigationController? {
        
        if let clsName = dict["clsName"] {
            
            let className = "WeiBo" + "." + "\(clsName as! String)"
            
            if let cls = NSClassFromString(className) as? UIViewController.Type {
                let controller = cls.init()

                
                controller.title = dict["title"] as! String?
                
                return UINavigationController(rootViewController: controller)
            }
            
        }
 
        return nil
    }
    
    
    
    
}













