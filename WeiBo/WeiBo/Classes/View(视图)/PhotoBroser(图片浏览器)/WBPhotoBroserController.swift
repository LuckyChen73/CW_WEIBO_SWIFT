//
//  WBPhotoBroserController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/8.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBPhotoBroserController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        
        setupUI()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension WBPhotoBroserController {
    
    func setupUI() {
        //设置 pageViewController
        //1. 创建pageViewController
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey: 20])
        
        //2. 将pageViewController添加到当前控制器
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        
        //3. 设置pageviewController的子控制器
        let photoViewer = WBPhotoViewController()
        pageViewController.setViewControllers([photoViewer], direction: .forward, animated: true, completion: nil)
        
        //4. 设置数据源并实现数据源方法
        pageViewController.dataSource = self
        
        //5. 添加手势: 给pageViewController添加一个手势, 手势的事件交给当前的控制器来处理
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        pageViewController.view.addGestureRecognizer(tap)
        self.view.gestureRecognizers = pageViewController.gestureRecognizers
        
        
        
    }
    
    func back() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
}


extension WBPhotoBroserController: UIPageViewControllerDataSource {
    
    /// 返回上一个控制器
    ///
    /// - Parameters:
    ///   - pageViewController: 当前的pageViewControler
    ///   - viewController: 当前显示的子控制器
    /// - Returns: 将要展示的前一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let photoViewer = WBPhotoViewController() as UIViewController
        return photoViewer
    }
    
    /// 返回上一个控制器
    ///
    /// - Parameters:
    ///   - pageViewController: 当前的pageViewControler
    ///   - viewController: 当前显示的子控制器
    /// - Returns: 将要展示的后一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let photoViewer = WBPhotoViewController() as UIViewController
        return photoViewer
        
    }
    
    
    
}








