//
//  WBTextView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/11.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBTextView: UITextView {

    var placeHolder: String = "请输入微博......" {
        didSet{
            plabel.text = "请输入微博......";
        }
    }
    
    /// 占位符
    fileprivate lazy var plabel: UILabel = UILabel(title: nil, titleColor: UIColor.lightGray, fontSize: 13)
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK: - 搭建 UI
extension WBTextView {
    
    func setupUI() {
        
        
    }
    
}


















