//
//  WBComposePicCell.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/12.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit

//协议
protocol WBComposePicCellDelegate: NSObjectProtocol {
    //添加或替换图片
    func addOrReplacePicture(cell: WBComposePicCell)
    //删除图片
    func deletePicture(cell: WBComposePicCell)
}


class WBComposePicCell: UICollectionViewCell {
    // 代理属性
    weak var delegate: WBComposePicCellDelegate?
    
    /// 添加或替换图片的按钮
    lazy var addOrReplaceButton: UIButton = UIButton(title: nil, target: self, selector: #selector(addOrReplacePicture), events: UIControlEvents.touchUpInside, bgImage: "compose_pic_add")
    
    /// 删除图片的按钮
    lazy var deleteButton: UIButton = UIButton(title: nil, target: self, selector: #selector(deletePicture), events: UIControlEvents.touchUpInside, bgImage: "compose_photo_close")
    
    
    var image: UIImage? {
        didSet{
            if let image = image { // 有值就给 cell的按钮设置图片
                addOrReplaceButton.setBackgroundImage(image, for: .normal)
                addOrReplaceButton.setBackgroundImage(image, for: .highlighted)
            } else {
                addOrReplaceButton.setBackgroundImage(UIImage(named: "compose_pic_add"), for: .normal)
                addOrReplaceButton.setBackgroundImage(UIImage(named: "compose_pic_add_highlighted"), for: .highlighted)
            }
            
            //如果image有值, 删除按钮就显示
            deleteButton.isHidden = image == nil

        }
    }
    
    
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
    @objc fileprivate func addOrReplacePicture() {
        delegate?.addOrReplacePicture(cell: self)
    }
    
    /// 删除图片
    @objc fileprivate func deletePicture() {
        delegate?.deletePicture(cell: self)
    }
}













