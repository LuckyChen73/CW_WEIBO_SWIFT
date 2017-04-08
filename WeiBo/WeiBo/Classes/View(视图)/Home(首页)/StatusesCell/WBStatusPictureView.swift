//
//  WBStatusPictureView.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 创建 UI
extension WBStatusPictureView {
    
    func setupUI() {
        self.backgroundColor = UIColor.yellow
    }
    
    
    
}











