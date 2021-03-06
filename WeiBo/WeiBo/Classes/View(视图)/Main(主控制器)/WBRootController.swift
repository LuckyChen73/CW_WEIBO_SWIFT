//
//  WBRootController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/2.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import MJRefresh

fileprivate let identifier = "identifer"

class WBRootController: UIViewController {
    
    /// 上下拉刷新控件
    lazy var refreshHeader: MJRefreshNormalHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
    lazy var refreshFooter: MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadData))
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        return tableView
    }()

    
    //访客视图
    var visitorView: WBVisitorView?
    
    //访客视图的文本，图标信息
    var visitorDic: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        //接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: loginSuccessNotification, object: nil)
    }

    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
}

// MARK: - 加载数据
extension WBRootController {
    func loadData() {
        
//        print("刷新了")
    }
}



// MARK: - 创建 UI
extension WBRootController {
    
    func setupUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        //tablewView一定要创建在visitorView的下面
        setupTableView()
        
        setupVisitorView()
        
        //添加上下拉刷新
        tableView.mj_header = refreshHeader
        tableView.mj_footer = refreshFooter
        
    }
    
    /// 设置tableView
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalTo(self.view)
        }
    }

    func setupVisitorView() {
        
        //只有在登录失败才加载访客视图
        if WBUserAccount.shared.isLogIn == false {
            //创建访客视图并设置大小
            visitorView = WBVisitorView(frame: self.view.bounds)
            
            //设置代理
            visitorView?.delegate = self
            
            //给访客视图的文本，图标信息赋值
            //visitorInfo 可空链式调用，如果前面有值，调用后面属性就有效果，反之
            visitorView?.visitorInfo = self.visitorDic
            
            self.view.addSubview(visitorView!)
        }
    }

    
    
    
}


// MARK: - 代理方法
extension WBRootController: WBVisitorViewDelegate {
    //实现代理方法
    func logIn() {
        //点击登录按钮后，跳转到登录控制器
        let wbLoginVC = WBLogInController()
        let navLoginVC = UINavigationController(rootViewController: wbLoginVC)
        present(navLoginVC, animated: true, completion: nil)
        
    }
    
    
}


// MARK: - 接收通知
extension WBRootController {
    //接收通知后的事件
    func loginSuccess() {
        
        visitorView?.removeFromSuperview()
        
        visitorView = nil
        
        //加载数据
        loadData()
    }
    
    
}


// MARK: - tableView 的数据源
extension WBRootController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}


// MARK: - UITableViewDelegate
extension WBRootController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
}




