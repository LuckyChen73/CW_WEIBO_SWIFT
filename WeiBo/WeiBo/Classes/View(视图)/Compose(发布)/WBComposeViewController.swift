//
//  WBComposeViewController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/11.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

private let identifier = "identifier"

class WBComposeViewController: UIViewController {
    /// 发布按钮
    lazy var composeBtn: UIButton = {
        //右侧
        let composeBtn = UIButton(title: "发布", titleColor:  UIColor.white, fontSize: 13, target: self, selector: #selector(compose), events: UIControlEvents.touchUpInside, bgImage: "tabbar_compose_button")
        //设置按钮失效状态
        composeBtn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .disabled)
        composeBtn.setTitleColor(UIColor.darkGray, for: .disabled)
        
        return composeBtn
    }()
    
    /// textView 自定义类定义对象时需要标识类型
    lazy var textView: WBTextView = WBTextView()
    
    /// 创建一个toolBar
    lazy var toolBar = UIToolbar()
    
    /// 配图视图的collectionView
    lazy var pictureView: UICollectionView = {
        //设置layout
        let layout = UICollectionViewFlowLayout()
        let cellWH = (screenWidh - 40)/3
        layout.itemSize = CGSize(width: cellWH, height: cellWH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        return collectionView
    }()
    
    // 释放通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //监听键盘的变化
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
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
        // 添加配图视图
        addPictureView()
        
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

        self.view.addSubview(toolBar)
        
        //设置toolBar的背景图片
        toolBar.setShadowImage(UIImage.pureImage(color: UIColor(white: 0.9, alpha: 0.9)), forToolbarPosition: .any)
        toolBar.setBackgroundImage(UIImage(named: "compose_toolbar_background"), forToolbarPosition: .any, barMetrics: .default)
        
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
    
    
    /// 设置配图视图
    func addPictureView() {
        pictureView.backgroundColor = UIColor.yellow
        textView.addSubview(pictureView)
        pictureView.snp.makeConstraints { (make) in
            make.left.equalTo(textView).offset(10)
            make.top.equalTo(textView).offset(100)
            make.size.equalTo(CGSize(width: screenWidh-20, height: screenWidh-20))
        }
    }
    
    
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension WBComposeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// 返回每一个 item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    /// 多少个 item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    /// 选中 item 时会调用
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
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
    
    /// 键盘将要改变 frame的时候调用
    ///
    /// - Parameter notification: 通知
    @objc fileprivate func keyboardWillChangeFrame(notification: Notification) {
        //取到 userInfo
        if let userInfo = notification.userInfo, let rect = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue, let animation = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
            //键盘将要移动到的 y 坐标的值
            let endY = rect.cgRectValue.origin.y
            let offset = endY - screenHeight //偏移值
            
            //更新 toolBar 的约束
            toolBar.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.view).offset(offset)
            })
            
            //给 toolBar 添加动画
            UIView.animate(withDuration: animation, animations: { 
                self.view.layoutIfNeeded()
            })
            
        }
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






