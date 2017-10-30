//
//  APIClient.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/10/30.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import Alamofire
import RxSwift

struct APIClient {

    static let shared = APIClient()
    static let manager = Alamofire.SessionManager.default

    private static func dataRequest(method: HTTPMethod = .get,
                                    api: API,
                                    encoding: ParameterEncoding = URLEncoding.default,
                                    headers: [String: String]? = nil) -> Observable<DataRequest> {
        return Observable<DataRequest>
            .create { (observer) -> Disposable in
                let url = api.buildURL
                let request = manager.request(url, method: method, parameters: api.parameters, encoding: encoding, headers: headers)
                observer.onNext(request)
                observer.onCompleted()
                return Disposables.create()
        }
    }
}
