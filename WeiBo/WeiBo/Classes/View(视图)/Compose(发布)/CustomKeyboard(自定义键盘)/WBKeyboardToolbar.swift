//
//  WBKeyboardToolbar.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/12.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

fileprivate let baseTag = 88


/// 协议
protocol WBKeyboardToolbarDelegate: NSObjectProtocol {
    /// 代理方法
    ///
    /// - Parameter section: <#section description#>
    func toggleKeyboard(section: Int)
}


class WBKeyboardToolbar: UIStackView {
    
    /// 代理
    weak var delegate: WBKeyboardToolbarDelegate?
    
    /// 记录选中的button
    var selectedButton: UIButton?
    
    var selectedIndex: Int = 0 {
        didSet {
            let selectedTag = selectedIndex + baseTag
            let button = viewWithTag(selectedTag) as! UIButton
            selectedButton?.isSelected = false
            button.isSelected = true
            selectedButton = button
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //水平还是垂直分布
        axis = .horizontal
        //等距均匀分布
        distribution = .fillEqually
        
        setupUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

// MARK: - UI 搭建
extension WBKeyboardToolbar {
    
    func setupUI() {
        //有关底部按钮信息的字典数组
        let buttonDicArr: [[String: Any]] = [["title": "最近", "image": "left"],
                                             ["title": "默认", "image": "mid"],
                                             ["title": "emoji", "image": "mid"],
                                             ["title": "浪小花", "image": "right"]]
        
        //遍历字典数组创建 button
        for (index,dic) in buttonDicArr.enumerated() {
            
            let title = dic["title"] as! String
            let imageName = dic["image"] as! String
            let normalImageName = "compose_emotion_table_\(imageName)_normal"
            let selectedImage = UIImage(named: "compose_emotion_table_\(imageName)_selected")
            
            let button = UIButton(title: title, titleColor: UIColor.white, fontSize: 16, target: self, selector: #selector(toggleKeyobard(button:)), bgImage: normalImageName)
            //设置button的选中状态的文字和背景图片
            button.setTitleColor(UIColor.darkGray, for: .selected)
            button.setBackgroundImage(selectedImage, for: .selected)
            
            button.tag = index + baseTag
            
            //和addSubView的效果是一样的
            addArrangedSubview(button)
            
            //默认选中第一个按钮
            if index == 0 {
                button.isSelected = true
                selectedButton = button
            }
            
        }

    }
}

// MARK: - 点击事件的处理
extension WBKeyboardToolbar {
    /// 切换键盘
    func toggleKeyobard(button: UIButton) {
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        
        //响应代理方法
        delegate?.toggleKeyboard(section: button.tag - baseTag)
    }
    
    
    
}

