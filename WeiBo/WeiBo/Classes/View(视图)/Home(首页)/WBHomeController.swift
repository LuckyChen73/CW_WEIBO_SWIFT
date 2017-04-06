//
//  WBHomeController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

fileprivate let identifer = "homeCell"

class WBHomeController: WBRootController {

    //保存微博数据的模型数组
    var dataSourceArr: [WBStatusModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册
        tableView.register(WBStatusCell.self, forCellReuseIdentifier: identifer)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        //判断用户是否为登录状态
        if WBUserAccount.shared.isLogIn == true {
            //加载数据
            loadData()
        }
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
            since_id = dataSourceArr.first?.id ?? 0
        }else {
            max_id = dataSourceArr.last?.id ?? 0
            isPullDown = false
        }
        //请求模型数据
        NetworkTool.shared.requsetStatus(sinceId: since_id, maxId: max_id) { (responseObject) in
          //对 responseObject做可选绑定
            if var statusModelArr = responseObject as? [WBStatusModel] {
                if isPullDown == true { //下拉刷新
                    //拼在新数据的后面
                    self.dataSourceArr = statusModelArr + self.dataSourceArr
                }else { //上拉刷新
                    //如果返回的数据大于1条, 则将第一条数据删除, 避免数据重复
                    if statusModelArr.count > 1 {
                        //去除第一条新数据，再拼接在原来数据的后面
                        statusModelArr.removeFirst()
                    }
                    self.dataSourceArr += statusModelArr
                }
                //刷新数据
                self.tableView.reloadData()
                
                //判断是上拉还是下拉，结束菊花转动
                if isPullDown == true {
                    self.refreshHeader.endRefreshing()
                }else {
                    self.refreshFooter.endRefreshing()
                }
                
            }
        }
    }
}



// MARK: - 数据源方法
extension WBHomeController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as! WBStatusCell
        //获取模型
        let model = dataSourceArr[indexPath.row]
//        cell.textLabel?.text = model.text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
}


// MARK: - UITableViewDelegate
extension WBHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}


