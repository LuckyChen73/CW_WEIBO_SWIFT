//
//  WBPhotoViewController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/9.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import SDWebImage

class WBPhotoViewController: UIViewController {

    /// 当前需要展示的图片的index
    var index: Int = 0
    
    /// 图片的url的数组
    var pic_urls: [String] = []
    
    /// scrollView
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.darkGray
        scrollView.frame = screenBounds
        return scrollView
    }()
    
    /// imageView
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = UIColor.yellow
        return imageView
    }()
    

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
        self.view.backgroundColor = UIColor.white
//        print("第\(index)张图片, url是\(pic_urls)")
        
        setupUI()
        
    }

}


// MARK: - 创建 UI
extension WBPhotoViewController {
    
    func setupUI() {
        //添加视图
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        //下载图片，根据图片来布局
        let url = URL(string: pic_urls[index])
        
        SDWebImageManager.shared().downloadImage(with: url!, options: [], progress: nil) { (image, _, _, _, _) in
            
            if let image = image {
                //先给图片赋值
                self.imageView.image = image
                
                //拿到图片的 size
                var imageSize = image.size
                //旧宽高
                let oldWidth = imageSize.width
                let oldHeight = imageSize.height
                
                
                // 新高/新宽 = 旧高/旧宽
                let newHeight = screenWidh * oldHeight / oldWidth
                
                //设置新 size
                imageSize = CGSize(width: screenWidh, height: newHeight)
                
                self.imageView.frame = CGRect(origin: CGPoint.zero, size: imageSize)
                
                //如果图片的高度小于屏幕高度
                if newHeight <= screenHeight {
                    //居中显示
                    self.imageView.center = self.scrollView.center
                    
                }else {
                    
                    self.scrollView.contentSize = imageSize
                }
                
            }
        }

    }
}













