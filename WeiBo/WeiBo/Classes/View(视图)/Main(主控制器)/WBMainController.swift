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
        
        //设置tabbar的阴影线条
        setupShadowImage()
        
        //添加新特性和欢迎页
        addNewFeatureAndWelcomeView()
    }

    //添加新特性和欢迎页
    func addNewFeatureAndWelcomeView() {
        
        let isNewFeature = Bundle.main.isNewFeature //判断是否有新特性
//        let isNewFeature = true
        //判断是否是新特性界面
        if (WBUserAccount.shared.isLogIn == true) {
            if isNewFeature == true {
                //展示新特性界面
                let newFeatureView = WBNewFetureView()
                self.view.addSubview(newFeatureView)
                
            }else {
                //展示欢迎页
                let welcomeView = WBWelcomeView()
                self.view.addSubview(welcomeView)
            }
        }
    }
    
    /// 设置tabbar的阴影线条, 下面的两个属性必须都要设
    func setupShadowImage () {
        tabBar.backgroundImage = UIImage(named: "tabbar_background")
        tabBar.shadowImage = UIImage.pureImage(color: UIColor(white: 0.9, alpha: 0.9))
    }

}


// MARK: - 点击事件
extension WBMainController {
    ///一旦事件使用了 fileprivate 或 private修饰，就必须加一个 @objc 修饰
    @objc fileprivate func composeMessage(button: UIButton) {
//        print("发布微博")
        
        let composeVC = WBComposeViewController()
        let nav = UINavigationController(rootViewController: composeVC)
        present(nav, animated: true, completion: nil)
        
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
        //获取  json 文件
        if let url = Bundle.main.url(forResource: "main.json", withExtension: nil),
            //将 url 文件转化成数据
            let object = try? Data(contentsOf: url),
            //反序列化得到可选Any值，进行强转成字典数组
            let dictArr = try? JSONSerialization.jsonObject(with: object, options: []) as! [[String: Any]] {
            //存储导航控制器的数组
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
            if let cls = NSClassFromString(className) as? WBRootController.Type {
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
                //将访客视图文本和图标的信息赋值给 controller
                controller.visitorDic = dict["visitorInfo"] as? [String: Any]
                
                return UINavigationController(rootViewController: controller)
            }
        }
        return nil
    }
}













