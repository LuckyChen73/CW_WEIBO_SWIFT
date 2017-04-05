//
//  WBLogInController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/4.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBLogInController: UIViewController {

    //webView 的懒加载属性
    lazy var webView: UIWebView = {
        //1.创建 webView 并设置 frame
        let webView = UIWebView(frame: self.view.bounds)
        //设置代理
        webView.delegate = self
        //2.返回 webView
        return webView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建 UI
        setupUI()
        
        //加载登录页面
        loadLoginPage()
    }
    
}


// MARK: - 创建 UI
extension WBLogInController {
    
    /// 创建 UI
    func setupUI() {
        self.view.backgroundColor = UIColor.yellow
        
        //添加 webView
        self.view.addSubview(webView)
        
        //添加返回按钮
        let backBtnItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        
        self.navigationItem.leftBarButtonItem = backBtnItem
    }
    
    //加载登录页面
    func loadLoginPage() {
        //url 字符串
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectURL)"
        //转换成 url 地址
        let url = URL(string: urlString)
        // 转为请求 request
        let request = URLRequest(url: url!)
        
        //网页加载请求
        webView.loadRequest(request)
    }
    
    
    
    
}


// MARK: - 点击事件
extension WBLogInController {
    
    func back() {
        //自己消失
        self.dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - webView 代理
extension WBLogInController: UIWebViewDelegate {
    //webView 代理方法
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("=========")
        print(request.url?.absoluteString) //打印请求的 url 字符串
        print("---------")
        
        //result = request.url?.absoluteString.hasPrefix("http://www.baidu.com")
        // query 是获取网址后所有的字符串
        if let urlString = request.url?.absoluteString, urlString.hasPrefix("http://www.baidu.com") == true, let query = request.url?.query {
            
            //根据上面获取的字符串范围，通过判断头部字符串，确定用户点击的是取消，还是授权
            if query.hasPrefix("code=") { //则为授权
                //拦截code http://www.baidu.com/?code=0d822614e628ed858c780b4634af6a64
                let subRange = urlString.range(of: "code=") //获取"code="的范围
                
                //range是一个index的区间值(lowerBound..<upperBound), upperBound取的是区间值的右边的index的值; lowerBounds可以取到械的index的值
                let code = urlString.substring(from: (subRange?.upperBound)!) //截取 code upperBound: 最大下标，上限
                
                //使用 code 获取 token
                NetworkTool.shared.requestToken(code: code, callBack: { (tokenDict) in
                    //空合运算符，如果 tokenDict 没有值就会打印 ?? 后面的值
                    print(tokenDict ?? "没有token")

                    //获取用户名和头像
                    if let tokenDict = tokenDict as? [String: Any] {
                        let uid = tokenDict["uid"] as! String
                        let token = tokenDict["access_token"] as! String
                        
                        //调用网络中间层的分类中获取用户信息的方法
                        NetworkTool.shared.requestUser(uid: uid, accessToken: token, callBack: { (userDict) in
                            print(userDict ?? "没有用户信息")
                            
                            //判断 userDict 是否有值
                            if var userDict = userDict as? [String: Any] {
                                //有值就合并
                                for (k, v) in tokenDict {
                                    print("-----------\(k)")
                                    userDict[k] = v
                                }
                                //保存信息
                                WBUserAccount.shared.save(dict: userDict)
                                
                                //登录成功之后发送通知
                                NotificationCenter.default.post(name: loginSuccessNotification, object: nil)

                                //退出登录界面
                                self.dismiss()
                            }
                        })
                    } else {
                        //没有获取到信息，退出登录界面
                        self.dismiss()
                    }
                })
                
            } else {
                //点击的是取消
                dismiss()
            }
            //不加载
            return false
        }
        //如果没有跳转的网址没有“http://www.baidu.com”前缀，则允许加载
        return true
    }
    
    //webView加载完成之后执行
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('userId').value='15773399189';document.getElementById('passwd').value='CW19951120")
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    

}










