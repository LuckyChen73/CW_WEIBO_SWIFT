//
//  WBEmotionTool.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/14.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import YYModel

class WBEmotionTool: NSObject {

    /// 单例
    static let shared: WBEmotionTool = WBEmotionTool()
    
    func parseInfoPlist(path: String) -> [WBEmotionModel]? {
        //取到 emotion 的本地路径
        let bundlePath = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil)
        //在取到里面default 文件夹的路径
        let defaultPath = bundlePath! + "/Contents/Resources/default/info.plist"
        
        //创建 emotion 模型数组
        var emotionModelArr: [WBEmotionModel] = []
        
        //先转为字典数组
        if let dicArr = NSArray(contentsOfFile: defaultPath) as? [[String: Any]] {
            //再转为模型数组
            emotionModelArr = NSArray.yy_modelArray(with: WBEmotionModel.self, json: dicArr) as! [WBEmotionModel]
        }
        
        
        return nil
    }
    
    
    
    
    
}
