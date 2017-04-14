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
    
    
    /// 计算属性
    var dataSourceArr: [[[WBEmotionModel]]] {
        //1.得到最近的二维数组
        let recentEmotions = devideEmotions(emotions: parseInfoPlist(path: defaultPath))
        
        //2. 得到默认的二维数组
        let defaultEmotions = devideEmotions(emotions: parseInfoPlist(path: defaultPath))
        
        //3. emoji
        let emojiEmotions = devideEmotions(emotions: parseInfoPlist(path: emojiPath))
        
        //4. lxh
        let lxhEmotions = devideEmotions(emotions: parseInfoPlist(path: lxhPath))
        
        return [recentEmotions, defaultEmotions, emojiEmotions, lxhEmotions]
    }
    
    /// 表情包的路径
    var bundlePath: String {
        return Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil)!
    }
    
    /// 默认表情的info.plist的路径
    var defaultPath: String {
        return bundlePath + "/Contents/Resources/default/info.plist"
    }
    
    /// emoji表情的info.plist的路径
    var emojiPath: String {
        return bundlePath + "/Contents/Resources/emoji/info.plist"
    }
    
    /// lxh表情的info.plist的路径
    var lxhPath: String {
        return bundlePath + "/Contents/Resources/lxh/info.plist"
    }
    
    
    
    /// 从 info.plist文件中解析表情
    ///
    /// - Parameter path:  info.plist 的路径
    /// - Returns: 对应的表情模型数组
    func parseInfoPlist(path: String) -> [WBEmotionModel] {
        //创建 emotion 模型数组
        var emotionModelArr: [WBEmotionModel] = []
        
        //先转为字典数组
        if let dicArr = NSArray(contentsOfFile: path) as? [[String: Any]] {
            //再转为模型数组
            emotionModelArr = NSArray.yy_modelArray(with: WBEmotionModel.self, json: dicArr) as! [WBEmotionModel]
        }
        
        return emotionModelArr
    }
    
    
    /// 生成一个 section 的数据源数组：将某种表情按照 cell 进行分组，20个一组，不足20个，单独分一组
    ///
    /// - Parameter emotions: 一个section 的所有表情的模型
    /// - Returns: 按 cell 分好组的表情的模型数组（二维数组）
    func devideEmotions(emotions: [WBEmotionModel]) -> [[WBEmotionModel]] {
        //一共要用几个 cell显示
        let pageCount = (emotions.count - 1)/20 + 1
        
        //创建一个空的二维数组
        var devideEmotions: [[WBEmotionModel]] = []
     
        //range 的起始位置
        var location = 0
        //range 的长度
        var length = 20
        
        //遍历获取各个 cell 的模型数组
        for i in 0..<pageCount {
            //判断要截取的那一页的表情是否满20, 如果不满20个, 有多个显示多少个
            if emotions.count - i * length < length {
                length = emotions.count - i * length
            }
            
            //每一页 cell 的表情的 range
            let range = NSMakeRange(location, length)
            
            //从大数组中截取一个cell 的表情
            //先转为 oc 数组，调用 oc中的方法，得到指定范围内的cell
            let emotionPerCell = (emotions as NSArray).subarray(with: range)
            
            //将截取到的表情数组放到二维数组中
            devideEmotions.append(emotionPerCell as! [WBEmotionModel])
            
            location += 20
        }
        
        return devideEmotions
        
    }
    
    
    
    
}
