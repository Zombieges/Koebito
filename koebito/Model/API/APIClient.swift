//
//  APIClient.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/10/30.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

struct APIClient {

    static let shared = APIClient()
    //static let manager = Alamofire.SessionManager.default

    func dataRequest(with kind: Int) -> Observable<VoicesRespose?> {
        return Observable<VoicesRespose?>
            .create { (observer) -> Disposable in
                let api = APISetting.getVoices(with: kind)
                let response = self._dataRequest(api: api)
//                    .flatMap{(res) in
//                        APIClient.shared.getImages(res: res as Any)
//                }

                _ = response.subscribe(
                    onNext: { (res) in
                        // json のエラーレスポンスをみてエラーハンドリング
                        observer.on(.next(res))
                        observer.onCompleted()
                        // error.localizedDescription を上位側で確認
                        //observer.onError(error)
                    },
                    onError: { (error) in
                        observer.onError(error)
                })
                return Disposables.create()
        }
    }
    
    private func _dataRequest(method: HTTPMethod = .get,
                     api: API,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: [String: String]? = nil) -> Observable<VoicesRespose?> {
        return Observable<VoicesRespose?>
            .create { (observer) -> Disposable in
                let url = api.buildURL
                let dataRequest = Alamofire.request(url, method: method, parameters: api.parameters, encoding: encoding, headers: headers).responseString { (response) in
                    switch response.result {
                    case .success(let value):
                        // TODO: ログ出力
                        guard let data = value.data(using: .utf8) else {
                            return
                        }
                        do {
                            let value = try? JSONDecoder().decode(VoicesRespose.self, from: data)
                            observer.on(.next(value))
                            observer.onCompleted()
                        } catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                debugPrint(dataRequest)
                return Disposables.create()
            }
    }
    func getImages(res: Any) -> Observable<UIImage>  {
        return Observable<UIImage>
        .create { (observer) -> Disposable in
            print(res)
            // get Kind type
            if let cellImage = Kinds.crying.image {
    
                observer.on(.next(cellImage))
                observer.onCompleted()
            }  else {
                let error = NSError(domain: "サンプル", code: 0, userInfo: nil)
                observer.onError(error)
                
            }
            
            return Disposables.create()
        }
    }
}
