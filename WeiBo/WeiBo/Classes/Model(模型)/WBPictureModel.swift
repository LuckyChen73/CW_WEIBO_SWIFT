//
//  WBPictureModel.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/5.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import YYModel

class WBPictureModel: NSObject {

    /// 微博的图片的缩略图的地址
    var thumbnail_pic: String?
    
    /// 描述信息
    override var description: String {
        return self.yy_modelDescription()
    }
    
}
