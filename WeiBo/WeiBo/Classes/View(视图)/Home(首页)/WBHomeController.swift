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
    
    /// WBStatusListViewModel
    var statusListViewModel: WBStatusListViewModel = WBStatusListViewModel()
    
    
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
        var isPullDown = true
        
        //判断是否是下拉刷新
        if refreshHeader.isRefreshing() {
            isPullDown = true
        } else {
            isPullDown = false
        }
        
        //调用 statusListViewModel 的获取数据的方法
        statusListViewModel.loadData(isPullDown: isPullDown) { (success) in
            self.tableView.reloadData()
            
            //如果获取数据成功
            if success == true {
                //判断是否是下拉刷新
                if isPullDown == true {
                    //停止下拉刷新
                    self.refreshHeader.endRefreshing()
                } else {
                    self.refreshFooter.endRefreshing()
                }
            }else {
                //判断是否是下拉刷新
                if isPullDown == true{
                    //停止下拉刷新
                    self.refreshHeader.endRefreshing()
                } else {
                    self.refreshFooter.endRefreshing()
                }
            }
        }
    }
}

// MARK: - 数据源方法
extension WBHomeController {

    //多少行
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.dataSourceArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取模型
        let viewModel = statusListViewModel.dataSourceArr[indexPath.row]
        
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



