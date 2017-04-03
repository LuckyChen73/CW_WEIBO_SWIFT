//
//  WBMainController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBMainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //创建及设置 UI
        setupUI()
        
    }

   

}


// MARK: - 点击事件
extension WBMainController {
    ///一旦事件使用了 fileprivate 或 private修饰，就必须加一个 @objc 修饰
    @objc fileprivate func composeMessage(button: UIButton) {
        
        print("发布微博")
        
    }
    

}




// MARK: - 创建 UI
extension WBMainController {
    
    //创建 UI
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        
        //添加子控制器
        addChildVC()
        
        //添加发布按钮
        addComposeButton()
        
    }
    
    //添加发布按钮
    fileprivate func addComposeButton() {
        
        let button = UIButton(title: nil, target: self, selector: #selector(composeMessage(button:)), events: UIControlEvents.touchUpInside, image: "tabbar_compose_icon_add", bgImage: "tabbar_compose_button")
        
        //设置 frame
        let width = tabBar.frame.width / 5
        //insetBy：以 tabbar 的中心点为原点，向内或向外扩张，所以此处必须调用 bounds
        button.frame = tabBar.bounds.insetBy(dx: width*2 - 3, dy: 6)
        
        tabBar.addSubview(button)
        
    }

    
    //添加子控制器
    fileprivate func addChildVC() {
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
    fileprivate func generateSingleVC(dict: [String: Any]) -> UINavigationController? {
        
        if let clsName = dict["clsName"] {
            //在 swift 中，字符串转换成类前面要添加类名
            let className = "WeiBo" + "." + "\(clsName as! String)"
            //as? UIViewController.Type 以什么类型的样式
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













