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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.randomColor()
        
        
        print("第\(index)张图片, url是\(pic_urls)")
        
        
    }


}
