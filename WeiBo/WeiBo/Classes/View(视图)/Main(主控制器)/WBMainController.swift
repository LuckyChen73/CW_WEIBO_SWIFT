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
                controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for: .normal)
                //这里设置底部 tabbar 的图标样式的时候，设置的是 button 的样式，所以要根据 button 来设置
                controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .selected)
                
                
                if let imageName = dict["imageName"] {
                    //tabbar_home
                    let image = UIImage(named: "tabbar_\(imageName)")
                    controller.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
                    
                    //tabbar_home_selected
                    let selectImage = UIImage(named: "tabbar_\(imageName)_selected")
                    controller.tabBarItem.selectedImage = selectImage?.withRenderingMode(.alwaysOriginal)
                }
                return UINavigationController(rootViewController: controller)
            }
            
        }
 
        return nil
    }
    
    
    
    
}













