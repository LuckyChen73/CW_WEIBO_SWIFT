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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifer)

        //加载数据
        loadData()
    
    }
}


// MARK: - 获取数据
extension WBHomeController {
    //加载数据
    override func loadData() {
        NetworkTool.shared.requsetStatus { (responseObject) in
          //对 responseObject做可选绑定
            if let statusModelArr = responseObject as? [WBStatusModel] {
                //模型数据拼接
                self.dataSourceArr += statusModelArr
                //刷新数据
                self.tableView.reloadData()
            }
        }
    }
}



// MARK: - 数据源方法
extension WBHomeController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath)
        //获取模型
        let model = dataSourceArr[indexPath.row]
        cell.textLabel?.text = model.text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
}





