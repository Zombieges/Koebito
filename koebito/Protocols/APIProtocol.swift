//
//  APIProtocol.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/10/30.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import Alamofire

protocol API {
    /// request URL(e.g. https://hogehoge/api/voices)
    var buildURL: URL { get }
    
    /// base URL(e.g. https://hogehoge/api)
    var baseURL: String { get }
    
    /// API's path(e.g. /voices)
    var path: String { get }
    
    /// Parameters with request (e.g. token=xoxp-xxx)
    var parameters: [String: Any]? { get }
}
