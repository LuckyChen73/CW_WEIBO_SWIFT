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

    override func viewDidLoad() {
        super.viewDidLoad()
        //注册
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifer)

    
    
    }

  

}

// MARK: - 数据源方法
extension WBHomeController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath)
        cell.textLabel?.text = "hello, world"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}





