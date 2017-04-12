//
//  NetworkTool.swift
//  WeiBo
//
//  Created by chenWei on 2017/4/4.
//  Copyright © 2017年 陈伟. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTool: AFHTTPSessionManager {
    //swift 中单例写法
//    static let shared: NetworkTool = NetworkTool()
    //创建单例
    static let shared: NetworkTool = {
        let tool = NetworkTool(baseURL: nil)
        //设置其可接受的格式
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tool
    }()
    
    
    /// 网络中间层
    ///
    /// - Parameters:
    ///   - url:  url 字符串
    ///   - method: 请求方式
    ///   - parameters: 请求参数
    ///   - callBack: 完成回调
    func requeset(url: String, method: String, parameters: Any?, callBack: @escaping (Any?)->()){
        //发起 get 请求
        if method == "GET" {
            self.get(url, parameters: parameters, progress: nil, success: { (_, responseData) in
                callBack(responseData)
            }, failure: { (_, error) in
                print(error)
                callBack(nil)
            })
        }
        
        //发起 post 请求
        if method == "POST" {
            self.post(url, parameters: parameters, progress: nil, success: { (_, responseData) in
                callBack(responseData)
            }, failure: { (_, error) in
                print(error)
                callBack(nil)
            })
        }
    }
    
    /// 网络中间层: 发起二进制的文件数据请求
    ///
    /// - Parameters:
    ///   - url: url字符串
    ///   - parameters: 文本参数
    ///   - data: 文件的二进制数据
    ///   - name: 服务器接收文件数据所需要的key
    ///   - fileName: 建议服务器保存的文件的名字
    ///   - callBack: 完成回调
    func upload(url: String, parameters: Any?, data: Data, name: String, fileName: String, callBack: @escaping (Any?)->()) {
        self.post(url, parameters: parameters, constructingBodyWith: { (formData) in
            formData.appendPart(withFileData: data, name: name, fileName: fileName, mimeType: "application/octet-stream")
        }, progress: nil, success: { (_, response) in
            callBack(response)
        }) { (_, error) in
            print(error)
            callBack(nil)
        }
    }
    
}
