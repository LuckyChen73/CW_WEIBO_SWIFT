//
//  WBStatusPictureView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import SDWebImage

let baseTag = 888

class WBStatusPictureView: UIView {

    //接收传过来的statusViewModel模型数据
    var statusViewModel: WBStatusViewModel? {
        didSet{


            //如果有图片
            if let pic_urls = statusViewModel?.pic_urls, pic_urls.count > 0 {
                
                var index = 0
                for pictureModel in pic_urls { // _ pictureModel
                    let imageView = self.viewWithTag(index + baseTag) as? UIImageView
                    imageView?.isHidden = false
                    
                    //添加图片
                    imageView?.wb_setImage(urlStr: pictureModel.thumbnail_pic!, placeHolderImage: "common_icon_membership_expired")
                    
                    //单张图片的处理
                    if index == 0 && pic_urls.count == 1 {
                        //图片的 frame
                        imageView?.frame = CGRect(origin: CGPoint.zero, size: (statusViewModel?.picSize)!)
                    }
                    //如果是第一张图片, 但是不止一张图片, 图片的宽高就按照九宫格的正方形大小显示
                    else if index == 0 && pic_urls.count != 1{
                        let imageWH = (screenWidh-40)/3
                        imageView?.frame = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
                        
                    }
 
                    //四张图片的处理
                    if pic_urls.count == 4 && index == 1 {
                        index += 1
                    }

                    index += 1
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 创建 UI
extension WBStatusPictureView {
    
    func setupUI() {
        self.backgroundColor = UIColor.yellow
        
        //裁剪超出配图部分
        self.clipsToBounds = true
        
        //imageView 的宽高
        let imageWH = (screenWidh - 40) / 3
        
        //移动一次就要调整 imageview 的 frame(水平和垂直的距离)
        let gap =  imageWH + 10
        
        let firstImageViewFrame = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
        //创建9个 imageView
        for i in 0..<9 {
            //创建
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.red
            
            imageView.tag = i + baseTag
            
            //计算行数和列数
            let row = i / 3
            let col = i % 3
            
            //计算 frame
            imageView.frame = firstImageViewFrame.offsetBy(dx: CGFloat(col) * gap, dy: CGFloat(row) * gap)
            
            addSubview(imageView)
            imageView.isHidden = true
            
            //设置图片的填充模式
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            //给imageView添加点击事件
            imageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageClicked(tap:)))
            imageView.addGestureRecognizer(tap)
            
        }
    }
}

// MARK: - 事件处理
extension WBStatusPictureView {
    @objc func imageClicked(tap: UITapGestureRecognizer) {
        print(tap)
        
        //需要将当前的配图视图的所有图片的 url 数组和被点击的图片的 index 传给图片视图控制浏览器
        var index = tap.view!.tag - baseTag
        //如果有四张图片, 图片是2*2显示的, 当到第三张图片时, 应该将index - 1
        if let pic_urls = statusViewModel?.pic_urls, pic_urls.count == 4, index > 2{
            index -= 1
        }
        
        //获取所有的url的字符串数组
        //从一个模型数组中, 取到属性数组; 这是oc中的类有相关的api, 而swift的数组没有这个api
        let urlStrs = ((statusViewModel?.pic_urls)! as NSArray).value(forKeyPath: "thumbnail_pic") as! [String]
        //参数：把字典通过通知的参数传过去
        let userInfo: [String: Any] = ["index": index, "urls": urlStrs]
        
        //创建通知
        let notification = Notification(name: pictureViewClickedNotification, object: nil, userInfo: userInfo)
        //发送通知
        NotificationCenter.default.post(notification)

    }
}









