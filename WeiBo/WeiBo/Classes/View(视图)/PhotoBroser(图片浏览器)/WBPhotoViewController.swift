//
//  WBPhotoViewController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/9.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBPhotoViewController: UIViewController {

    /// 当前需要展示的图片的index
    var index: Int = 0
    
    /// 图片的url的数组
    var pic_urls: [String] = []
    
    
    /// 重载构造函数
    init(index: Int, pic_urls: [String]) {
        super.init(nibName: nil, bundle: nil)
        
        self.index = index
        self.pic_urls = pic_urls
        
    }
    /// 一旦重载UIView或者UIViewController的构造函数, 则必须实现该方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.randomColor()
        
        
//        print("第\(index)张图片, url是\(pic_urls)")
        
        
    }


}
