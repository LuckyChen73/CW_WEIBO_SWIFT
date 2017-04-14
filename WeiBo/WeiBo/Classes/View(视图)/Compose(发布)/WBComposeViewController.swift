//
//  WBComposeViewController.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/11.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import SVProgressHUD

private let identifier = "identifier"

private let maxPicCount = 8

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
        collectionView.register(WBComposePicCell.self, forCellWithReuseIdentifier: identifier)
        
        return collectionView
    }()
    
    
    /// 数据源数组
    var dataSourceArr: [UIImage] = []
    
    /// 选中 item 下标
    var selectedIndex: Int = 0
    
    /// 记录键盘类型： 0是系统键盘，1是自定义键盘
    var keyboardType: Int = 0
    
    /// toolbar 是否执行动画
    var isAnimation: Bool = true
    
    /// 自定义键盘
    lazy var customKeyboard: WBCustomKeyboard = {
        let mykeyborad = WBCustomKeyboard(frame: CGRect(x: 0, y: 0, width: screenWidh, height: 216))
        mykeyborad.backgroundColor = UIColor(patternImage: UIImage(named: "emoticon_keyboard_background")!)
        return mykeyborad
    }()
    
    // 释放通知
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //监听键盘的变化
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
   
        //接收插入或是删除的通知
        NotificationCenter.default.addObserver(self, selector: #selector(insertOrDeleteEmotion(notification:)), name: emotionButtonClickedNotification, object: nil)
    
    }


}

// MARK: - 处理插入或删除文本的操作
extension WBComposeViewController {
    
    @objc fileprivate func insertOrDeleteEmotion(notification: Notification) {
        
        //print(notification)
        if let userInfo = notification.userInfo, let action = userInfo["action"] as? Bool {
            //删除操作
            if action == false {
                print("删除")
            }
            //插入操作
            else {
                // 取出表情
                if let emotion = userInfo["emotion"] as? WBEmotionModel {
                    print("插入")
                    
                }
            }
        }

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
        
    
        //标题
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
        pictureView.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        textView.addSubview(pictureView)
        pictureView.snp.makeConstraints { (make) in
            make.left.equalTo(textView).offset(10)
            make.top.equalTo(textView).offset(100)
            make.size.equalTo(CGSize(width: screenWidh-20, height: screenWidh-20))
        }
    }
    
    
    
    
}

// MARK: - WBComposePicCellDelegate 代理方法
extension WBComposeViewController: WBComposePicCellDelegate {
    /// 实现代理方法  添加或替换
    func addOrReplacePicture(cell: WBComposePicCell) {
        //获取选中 item 下标
        selectedIndex = (pictureView.indexPath(for: cell)?.item)!
        
        //创建系统相册
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    /// 删除
    func deletePicture(cell: WBComposePicCell) {
        let index = (pictureView.indexPath(for: cell)?.item)!
        dataSourceArr.remove(at: index)
        //刷新 collectionView
        pictureView.reloadData()
    }

}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension WBComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 完成图片选中
    ///
    /// - Parameters:
    ///   - picker: UIImagePickerController
    ///   - info: 图片参数
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        originalImage.resizeImage(size: CGSize(width:100, height:100)) { (image) in
        
            //判断图片是添加，替换
            if self.selectedIndex == self.dataSourceArr.count {
                //选中的是加号按钮,添加图片
                self.dataSourceArr.append(image!)
            }else {
                //替换
                self.dataSourceArr[self.selectedIndex] = image!
            }
            
            //刷新 collectionView
            self.pictureView.reloadData()
            
            //dismiss
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension WBComposeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// 返回每一个 item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! WBComposePicCell
        cell.backgroundColor = UIColor.randomColor()
        cell.delegate = self
        
        // 如果没有达到最大图片张数，并且是最后一个 cell，那么就显示加号按钮，否则就把图片赋值为 nil
        if indexPath.item == dataSourceArr.count {
            cell.image = nil
        }else {
            cell.image = dataSourceArr[indexPath.item]
        }
        
        return cell
    }
    
    /// 多少个 item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArr.count == maxPicCount ? maxPicCount : dataSourceArr.count + 1
    }
    
    /// 选中 item 时会调用
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.item)
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
        
        //显示正在转动的菊花
        SVProgressHUD.show()
        let status = (textView.text)!
        
        //默认值为 nil
        var imageData: Data?
        
        if dataSourceArr.count > 0 {
            // UIImagePNGRepresentation 把图片转换成二进制数据
            imageData = UIImagePNGRepresentation(dataSourceArr[0])
        }
        
        NetworkTool.shared.updateStatus(status: status, imageData: imageData) { (response) in
            //消除菊花
            SVProgressHUD.dismiss()
            
            //重设第一响应者，收起键盘
            self.textView.resignFirstResponder()
            
            //延迟一秒执行
            after(1, { 
                self.dismiss(animated: true, completion: nil)
            })
            
        }
        
    }
    
    /// 切换键盘
    func changeKeyBoard() {
    
        isAnimation = false
        textView.resignFirstResponder() // 收起键盘
        isAnimation = true
        
        //是系统键盘，切换到自定义键盘
        if keyboardType == 0 {
            textView.inputView = self.customKeyboard
            keyboardType = 1
            
        }else {
            textView.inputView = nil
            keyboardType = 0
        }
        // 弹出键盘
        textView.becomeFirstResponder()
    }
    
    /// 键盘将要改变 frame的时候调用
    ///
    /// - Parameter notification: 通知
    @objc fileprivate func keyboardWillChangeFrame(notification: Notification) {
        if isAnimation == true {
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
}


// MARK: - 文本输入代理
extension WBComposeViewController: UITextViewDelegate {
    
    /// 文本变动
    ///
    /// - Parameter textView: textView
    func textViewDidChange(_ textView: UITextView) {
        //发布跟随文本视图的联动
        composeBtn.isEnabled = textView.text.characters.count > 0
    }
    
    
}






