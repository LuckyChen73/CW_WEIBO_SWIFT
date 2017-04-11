//
//  WBComposeViewController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/11.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBComposeViewController: UIViewController {

    lazy var composeBtn: UIButton = {
        //右侧
        let composeBtn = UIButton(title: "发布", titleColor:  UIColor.white, fontSize: 13, target: self, selector: #selector(compose), events: UIControlEvents.touchUpInside, bgImage: "tabbar_compose_button")
        //设置按钮失效状态
        composeBtn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .disabled)
        composeBtn.setTitleColor(UIColor.darkGray, for: .disabled)
        
        return composeBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }


}

// MARK: - 搭建 UI
extension WBComposeViewController {
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        // 设置自动调整布局为 false，默认是 true
        self.automaticallyAdjustsScrollViewInsets = false
        // 添加取消按钮
         addNavigationBarButton()
        // 添加文本视图
        setupTextView()
        // 添加 toolBar
        addToolBar()
        
    }
    
    /// 添加取消按钮
    func addNavigationBarButton() {
        //取消按钮
        let cancelBtn = UIButton(title: "取消", titleColor:  UIColor.white, fontSize: 13, target: self, selector: #selector(cancel), events: UIControlEvents.touchUpInside, bgImage: "tabbar_compose_button")
        cancelBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        let left = UIBarButtonItem(customView: cancelBtn)
        self.navigationItem.leftBarButtonItem = left
        
        //发布按钮
        composeBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        let right = UIBarButtonItem(customView: composeBtn)
        self.navigationItem.rightBarButtonItem = right
        //取消按钮的点击
        //设置button是否可以点击必须在将button添加到父视图上之后, 才可以生效
        composeBtn.isEnabled = false
        
        
        //标题师傅
        let title = UILabel(title: nil, alignment: .center)
        let titleText = NSMutableAttributedString(string: "发布微博\n", attributes: [NSForegroundColorAttributeName: UIColor.darkGray, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)])
        
        let userText = NSAttributedString(string: "\((WBUserAccount.shared.screen_name)!)", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)])
        titleText.append(userText)
        //把titleText设为 titleLab 的富文本属性
        title.attributedText = titleText
        title.sizeToFit()
        self.navigationItem.titleView = title
        

    }
    
    
    /// 添加文本视图
    func setupTextView () {
        let textView = WBTextView()
        textView.placeHolder = "hello, world....."
        
        textView.delegate = self
        
        self.view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
    
    /// 添加 toolBar
    func addToolBar() {
        //1. 创建一个toolBar
        let toolBar = UIToolbar()
        self.view.addSubview(toolBar)
        
        //设置toolBar的自动布局
        //toolBar有默认高度, 所以不需要设高度
        toolBar.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
        }
        
        //创建toolBar的items的参数字典字数组
        let dicArray: [[String: Any]] = [["image":"compose_mentionbutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_trendbutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_camerabutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_emoticonbutton_background", "selector": #selector(changeKeyBoard)], ["image":"compose_keyboardbutton_background", "selector": #selector(changeKeyBoard)]]
        
        var items: [UIBarButtonItem] = []
        //遍历字典数组
        for dic in dicArray {
            let button = UIButton(title: nil, target: self, selector: dic["selector"] as! Selector?, events: UIControlEvents.touchUpInside, image: dic["image"] as! String?)
            button.sizeToFit()
            let item = UIBarButtonItem(customView: button)
            //弹簧间隔
            let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            
            items.append(item)
            items.append(flexibleItem)
        }
        //移除最后一个
        items.removeLast()
        toolBar.items = items
    }
    
    
    
    
    
    
}

// MARK: - 点击事件
extension WBComposeViewController {
    
    /// 点击取消按钮
    func cancel() {
        dismiss(animated: true, completion: nil)

    }
    
    /// 发布微博
    func compose() {
        print("发布微博")
    }
    
    /// 改变键盘
    func changeKeyBoard() {
        print("改变键盘")
    }
    
    
    
    
}

extension WBComposeViewController: UITextViewDelegate {
    
    /// 文本变动
    ///
    /// - Parameter textView: textView
    func textViewDidChange(_ textView: UITextView) {
        //发布跟随文本视图的联动
        composeBtn.isEnabled = textView.text.characters.count > 0
    }
    
    
}






