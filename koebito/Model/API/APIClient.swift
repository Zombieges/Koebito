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
    
    func dataRequest(with kind: Int) -> Observable<Any> {
        return Observable<Any>
            .create { (observer) -> Disposable in
                let api = APISetting.getVoices(with: kind)
                let response = self._dataRequest(api: api)
//                    .flatMap{(res) in
//                        APIClient.shared.getImages(res: res as Any)
//                }
                
                _ = response.subscribe(
                    onNext: { (res) in
                        
//                        guard let data = res.data else {
//                            let error = res.error
//                            observer.onError(error!)
//                            return
//                        }
                        
                        do {
                            let value = try? JSONDecoder().decode(VoicesRespose.self, from: res)
                            //
                            //                        let encoder = JSONEncoder()
                            //                        encoder.outputFormatting = .prettyPrinted
                            //let encoded = try! encoder.encode(value)
                            print(value)
                            
                            // TODO モデルに突っ込む
                            
                            observer.on(.next(value))
                            observer.onCompleted()
                        } catch {
                            // error.localizedDescription を上位側で確認
                            observer.onError(error)
                        }
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
                     headers: [String: String]? = nil) -> Observable<Data> {
        return Observable<Data>
            .create { (observer) -> Disposable in
                let url = api.buildURL
//                let dataRequest = Alamofire.request(url, method: method, parameters: api.parameters, encoding: encoding, headers: headers)
//                debugPrint(dataRequest)
//                // TODO: レスポンスデータログを出力
//
//                dataRequest.response {(response) in
//                    guard let data = response.data else {
//                        return
//                    }
//
//                    observer.on(.next(data))
//                    observer.onCompleted()
//                }
                let dataRequest = Alamofire.request(url, method: method, parameters: api.parameters, encoding: encoding, headers: headers).responseString { (response) in
                    switch response.result {
                    case .success(let value):
                        // TODO: ログ出力
                        //print(value)
                        guard let data = value.data(using: .utf8) else {
                            return
                        }
                        observer.on(.next(data))
                        observer.onCompleted()

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
    
//    private func _dataRequest(method: HTTPMethod = .get,
//                              api: API,
//                              encoding: ParameterEncoding = URLEncoding.default,
//                              headers: [String: String]? = nil) -> Observable<Any> {
//        return Observable<Any>
//        .create { (observer) -> Disposable in
//            let url = api.buildURL
//            //let request = manager.request(url, method: method, parameters: api.parameters, encoding: encoding, headers: headers)
//            Alamofire.request(url, method: method, parameters: api.parameters, encoding: encoding, headers: headers).responseJSON { (response:
//                DataResponse<Any>) in
//                switch response.result {
//                case .success(let res):
//                    // データ取得成功したの保存します。
//                    //                        let realm = try! Realm()
//                    //                        try! realm.write {
//                    //                            // 「update: true」のオプションに関しては今回は割愛します。
//                    //                            realm.add(prefectures)
//                    //                        }
//
//                    // [変更] 通知の処理は「observer」に任せる。
//
//                    // error ハンドドリング
////                    if  {
////                        let error = NSError(coder: "リクエストの取得に失敗", )
////                        observer.onError(error)
////                    }
//
//                    observer.on(.next(res))
//                    observer.onCompleted()
//                case .failure(let error):
//                    // データ取得エラー
//
//                    // [変更] 通知の処理は「observer」に任せる。
//                    observer.onError(error)
//                }
//            }
//            return Disposables.create()
//        }
//    }
//    func getUserImage() -> Observable<Any> {
//        // キャシュがあればカッシュを使用
//        // なければ ストレージから取得
//    }
}
