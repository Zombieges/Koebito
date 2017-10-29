//
//  APIProtocol.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/10/30.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

protocol API {
    /// Request URL(e.g. https://hogehoge/api)
    var baseURL: String { get }
    
    /// API's path(e.g. /xxxxx)
    var path: String { get }
    
    /// Parameters with request (e.g. token=xoxp-xxx)
    var parameters: [String: Any]? { get }
}
