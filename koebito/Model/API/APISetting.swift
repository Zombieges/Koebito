//
//  APISetting.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/10/30.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import Alamofire

enum APISetting: API {
    
    /// get voices
    case getVoices(with: Int)
    case getVoicesOfSpecificUser(userId: String)
    
    /// get users
    //case chatPostMessage(text: String, channel: String, options: [String: String])
    
    /// :
    /// ファイルのアップロード
    /// case fileUpload(filename: String, file: Data, options: [String: String])
    
    /// Token 
    static let token = "xoxp-xxx"
    
    var buildURL: URL {
        return URL(string: "\(baseURL)\(path)")!
    }
    
    var baseURL: String {
        return "https://koebito-api.herokuapp.com/api"
    }
    
    var path: String {
        switch self {
        case .getVoices, .getVoicesOfSpecificUser: return "/voices"
        //case .chatPostMessage(text: _, channel: _, options: _): return "/chat.postMessage"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getVoices(with: let kind):
            let touples = [("kind", kind)]
            let params = Dictionary(uniqueKeysWithValues: touples)
            return params
        case .getVoicesOfSpecificUser(userId: let userId):
            let touples = [("userId", userId)]
            let params = Dictionary(uniqueKeysWithValues: touples)
            return params
//        case .chatPostMessage(text: let text, channel: let channel, options: let options):
//            var params: Parameters
//            return params
        }
    }
}
