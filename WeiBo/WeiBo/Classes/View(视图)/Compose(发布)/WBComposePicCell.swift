//
//  WBComposePicCell.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/12.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

class WBComposePicCell: UICollectionViewCell {
    
    /// 添加或替换图片的按钮
    lazy var addOrReplaceButton: UIButton = UIButton(title: nil, target: self, selector: #selector(addOrReplacePicture), events: UIControlEvents.touchUpInside, bgImage: "compose_pic_add")
    
    /// 删除图片的按钮
    lazy var deleteButton: UIButton = UIButton(title: nil, target: self, selector: #selector(deletePicture), events: UIControlEvents.touchUpInside, bgImage: "compose_photo_close")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

// MARK: - UI 搭建
extension WBComposePicCell {
    
    func setupUI() {
        self.contentView.addSubview(addOrReplaceButton)
        self.contentView.addSubview(deleteButton)
        
        addOrReplaceButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.right).offset(-23)
            make.top.equalTo(self)
        }
        
        
    }
}


// MARK: - 点击事件的处理
extension WBComposePicCell {
    
    /// 添加或更换图片
    func addOrReplacePicture() {
        
        print("添加或更换")
    }
    
    /// 删除图片
    func deletePicture() {
        
         print("删除")
    }
}













