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
    //static let manager = Alamofire.SessionManager.default
    
    func dataRequest(method: HTTPMethod = .get,
                     api: API,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: [String: String]? = nil) -> Observable<Any> {
        return Observable<Any>
            .create { (observer) -> Disposable in
                let url = api.buildURL
                //let request = manager.request(url, method: method, parameters: api.parameters, encoding: encoding, headers: headers)
                Alamofire.request(url, method: method, parameters: api.parameters, encoding: encoding, headers: headers).responseJSON { (response:
                    DataResponse<Any>) in
                    switch response.result {
                    case .success(let res):                        
                        // error ハンドドリング
                        //                    if  {
                        //                        let error = NSError(coder: "リクエストの取得に失敗", )
                        //                        observer.onError(error)
                        //                    }
                        
                        observer.on(.next(res))
                        observer.onCompleted()
                    case .failure(let error):
                        // データ取得エラー
                        
                        // [変更] 通知の処理は「observer」に任せる。
                        observer.onError(error)
                    }
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
