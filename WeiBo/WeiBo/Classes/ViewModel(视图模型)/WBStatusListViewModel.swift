//
//  WBStatusListViewModel.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/9.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import SDWebImage

class WBStatusListViewModel: NSObject {

    //保存微博数据的模型数组
    var dataSourceArr: [WBStatusViewModel] = []
    
    
    
    /// 获取首页数据
    ///
    /// - Parameters:
    ///   - isPullDown: 是否下拉
    ///   - callBack: 闭包
    func loadData(isPullDown: Bool, callBack: @escaping (Bool)->()) {
        var since_id: Int64 = 0  //返回比微博 id 大的微博数据
        var max_id: Int64 = 0 //返回等于或小于当前微博 id 的微博数据
        
        //正在下拉刷新, since_id要传值 , max_id传0
        if isPullDown {
            since_id = dataSourceArr.first?.statusModel.id ?? 0
        } else {
            max_id = dataSourceArr.last?.statusModel.id ?? 0
        }
        

        //请求模型数据
        NetworkTool.shared.requsetStatus(sinceId: since_id, maxId: max_id) { (responseObject) in
            //对 responseObject做可选绑定
            if let statusModelArr = responseObject as? [WBStatusModel] {
                //创建一个保存 WBStatusViewModel的空数组
                var viewModelArr: [WBStatusViewModel] = []
                
                for statusModel in statusModelArr {
                    //将 statusModel外面包一层 statusViewModel
                    let viewModel = WBStatusViewModel(statusModel: statusModel)
                    viewModelArr.append(viewModel)
                }
                
                //数据拼接: 如果是下拉, 将获取的数据塞到数据源的前面; 如果是下拉, 将获取的数据拼在数据源的后面
                if isPullDown == true {
                    self.dataSourceArr = viewModelArr + self.dataSourceArr
                }else {
                    if viewModelArr.count > 0 {
                        viewModelArr.removeFirst()
                    }
                    self.dataSourceArr += viewModelArr
                }
                
                //在reload TableView之前, 先下载所有的单张图片
                self.dealWithSinglePicture(viewModelArr: viewModelArr, callBack: callBack)
                
            }else {
                //失败后回调
                callBack(false)
            }
        }
    }
    
    
    /// 处理所有的单张图片
    ///
    /// - Parameters:
    ///   - viewModelArr: 视图模型数组
    ///   - callBack: 完成回调
    func dealWithSinglePicture(viewModelArr: [WBStatusViewModel], callBack: @escaping (Bool)->()) {
        
        //创建一个调度组
        let group = DispatchGroup()
        
        //1.遍历视图模型数组,找到单张图片
        for viewModel in viewModelArr {
            //判断是不是单张图片
            if let pic_urls = viewModel.pic_urls, pic_urls.count == 1 {
                //入组
                group.enter()
                
                //图片url
                let urlStr = pic_urls[0].bmiddle_pic
                let url = URL(string: urlStr!)
                
                SDWebImageManager.shared().downloadImage(with: url!, options: [], progress: nil, completed: { (singleImage, _, _, _, _) in
                    //计算单张图片的 size，并更新 viewModel
                    if let singleImage = singleImage {
                        
                        var singleImageSize = singleImage.size
                        //如果图片超过屏幕宽度
                        let newWidth = screenWidh - 40
                        //如果超过配图的宽度
                        if singleImageSize.width > screenWidh - 20 {
                            // 新高/新宽 = 原高/原宽
                            singleImageSize.height = singleImageSize.height * newWidth / singleImageSize.width
                            
                            singleImageSize.width = newWidth
                        }
                        //把单张图片的大小传过去
                        viewModel.picSize = singleImageSize
                        
                        //离组
                        group.leave()
                    }
                })
            }
        }
        
        //完成组中所有操作，调用的方法
        group.notify(queue: DispatchQueue.main) {
            callBack(true)
        }
    }

    
}




