//
//  WBPhotoBroserController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/8.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBPhotoBroserController: UIViewController {

    /// 当前需要展示的图片的index
    var index: Int = 0
    
    /// 图片的url的数组
    var pic_urls: [String] = []
    
    /// 重载构造函数
    init(index: Int, pic_urls: [String]) {
        super.init(nibName: nil, bundle: nil)
//        print("======\(index, pic_urls)---------")
        self.index = index
        self.pic_urls = pic_urls
    }
    /// 一旦重载UIView或者UIViewController的构造函数, 则必须实现该方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        
        setupUI()
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    

}

// MARK: - 创建 UI
extension WBPhotoBroserController {
    
    func setupUI() {
        //设置 pageViewController
        //1. 创建pageViewController
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey: 0])
        
        //2. 将pageViewController添加到当前控制器
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        
        //3. 设置pageviewController的子控制器
        let photoViewer = WBPhotoViewController(index: index, pic_urls: pic_urls)
        pageViewController.setViewControllers([photoViewer], direction: .forward, animated: true, completion: nil)
        
        //4. 设置数据源并实现数据源方法
        pageViewController.dataSource = self
        
        //5. 添加手势: 给pageViewController添加一个手势, 手势的事件交给当前的控制器来处理
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        pageViewController.view.addGestureRecognizer(tap)
        self.view.gestureRecognizers = pageViewController.gestureRecognizers
        
    }
    
    /// 点击手势执行的方法
    func back() {
        
        dismiss(animated: true, completion: nil)
        
    }
}


// MARK: - UIPageViewControllerDataSource
extension WBPhotoBroserController: UIPageViewControllerDataSource {
    
    /// 返回上一个控制器
    ///
    /// - Parameters:
    ///   - pageViewController: 当前的pageViewControler
    ///   - viewController: 当前显示的子控制器
    /// - Returns: 将要展示的前一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //先取到当前下标
        let currentIndex = (viewController as! WBPhotoViewController).index
        //再判断
        if currentIndex == 0 {
            print("到头了")
            return nil
        }
        
        let photoViewer = WBPhotoViewController(index: currentIndex - 1, pic_urls: pic_urls) as UIViewController
        return photoViewer

    }
    
    /// 返回下一个控制器
    ///
    /// - Parameters:
    ///   - pageViewController: 当前的pageViewControler
    ///   - viewController: 当前显示的子控制器
    /// - Returns: 将要展示的后一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //当前下标
        let currentIndex = (viewController as! WBPhotoViewController).index
        //判断是否到尾
        if currentIndex == pic_urls.count - 1 {
            print("到尾了")
            return nil

        }
        
        let photoViewer = WBPhotoViewController(index: currentIndex + 1, pic_urls: pic_urls) as UIViewController
        return photoViewer
    }

}







