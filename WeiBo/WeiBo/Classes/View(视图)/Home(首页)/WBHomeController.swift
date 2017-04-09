//
//  WBHomeController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import SDWebImage

fileprivate let statusIdentifer = "statusIdentifer"
fileprivate let retweetedIdentifer = "retweetedIdentifer"

class WBHomeController: WBRootController {

    //保存微博数据的模型数组
    var dataSourceArr: [WBStatusViewModel] = []
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册
        tableView.register(WBStatusCell.self, forCellReuseIdentifier: statusIdentifer)
        tableView.register(WBRetweetedStatusCell.self, forCellReuseIdentifier: retweetedIdentifer)
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        //判断用户是否为登录状态
        if WBUserAccount.shared.isLogIn == true {
            //加载数据
            loadData()
        }
        
        
        //接收微博首页的图片点击的通知
        NotificationCenter.default.addObserver(self, selector: #selector(showPhotoBroser (notification:)), name: pictureViewClickedNotification, object: nil)
        
        
        
    }
}

// MARK: - 事件处理
extension WBHomeController {
    func showPhotoBroser (notification: Notification) {
        //创建图片轮播控制器
        let userInfo = notification.userInfo
        
        let index = userInfo?["index"] as! Int
        let pic_urls = userInfo?["urls"] as! [String]
        
        let photoBroser = WBPhotoBroserController(index: index, pic_urls: pic_urls)
        present(photoBroser, animated: false, completion: nil)
    }
}




// MARK: - 获取数据
extension WBHomeController {
    //加载数据
    override func loadData() {
        var since_id: Int64 = 0  //返回比微博 id 大的微博数据
        var max_id: Int64 = 0 //返回等于或小于当前微博 id 的微博数据
        
        //是否下拉
        var isPullDown = true
        
        //正在下拉，since_id 要传值，max_id 要传0
        if refreshHeader.isRefreshing() == true {
            since_id = dataSourceArr.first?.statusModel.id ?? 0
        }else { // dataSourceArr.last? 取出来是 statusViewModel
            max_id = dataSourceArr.last?.statusModel.id ?? 0
            isPullDown = false
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
                
                if isPullDown == true { //下拉刷新
                    //拼在新数据的后面
                    self.dataSourceArr = viewModelArr + self.dataSourceArr
                }else { //上拉刷新
                    //如果返回的数据大于1条, 则将第一条数据删除, 避免数据重复
                    if viewModelArr.count > 1 {
                        //去除第一条新数据，再拼接在原来数据的后面
                        viewModelArr.removeFirst()
                    }
                    self.dataSourceArr += viewModelArr
                }
                //刷新数据
                self.tableView.reloadData()
                
                //判断是上拉还是下拉，结束菊花转动
                if isPullDown == true {
                    self.refreshHeader.endRefreshing()
                }else {
                    self.refreshFooter.endRefreshing()
                }
                
                
                //在reload TableView之前, 先下载所有的单张图片
                self.dealWithSinglePicture(viewModelArr: viewModelArr, callBack: { (isSuccess) in
                    
                    self.tableView.reloadData()
                    
                    //判断是上拉还是下拉，结束菊花转动
                    if isPullDown == true {
                        self.refreshHeader.endRefreshing()
                    }else {
                        self.refreshFooter.endRefreshing()
                    }
   
                })
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



// MARK: - 数据源方法
extension WBHomeController {

    //多少行
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取模型
        let viewModel = dataSourceArr[indexPath.row]
        
        //如果有转发微博
        if let _ = viewModel.statusModel.retweeted_status {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: retweetedIdentifer, for: indexPath) as! WBRetweetedStatusCell
            cell.statusViewModel = viewModel
            return cell

        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: statusIdentifer, for: indexPath) as! WBStatusCell
            cell.statusViewModel = viewModel
            return cell
        }
        
    }
    
    
}



