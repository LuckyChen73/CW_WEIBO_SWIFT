//
//  WBOriginalStatusView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBOriginalStatusView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //添加一个微博正文的label
    lazy var statusLabel: UILabel = UILabel(title: nil)
    
}


extension WBOriginalStatusView {
    
    func setupUI() {
        
        addSubview(statusLabel)
        
        statusLabel.numberOfLines = 0
        statusLabel.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
        
        //测试用的值:
        var string = "苍井波多哦哦哦, 感觉自己蒙蒙的;"
        let randomCount = arc4random() % 20 + 1 //获取1到20的随机数
        for _ in 0..<randomCount {
            string += "苍井波多哦哦哦, 感觉自己蒙蒙的"
        }
        
        statusLabel.text = string

        
    }
    
    
    
}















