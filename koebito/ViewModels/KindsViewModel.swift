//
//  KindsViewModel.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/10/23.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import Foundation
import RxSwift

class KindsViewModel {
    //let 
    
    
//    enum TriggerType {
//        case refresh, loadMore
//    }
//    
//    var models: Observable<[VoicesInformations]> = Observable.empty()
//    
//    init(inputs: (refreshTrigger: Observable<Void>, loadMoreTrigger: Observable<Void>)) {
//        // UI イベントのストリームをマージして一つのストリームにする
//        let requestTrigger: Observable<TriggerType> = Observable
//            .merge(
//                inputs.refreshTrigger.map { .refresh },
//                inputs.loadMoreTrigger.map { .loadMore }
//        )
//        
//        // UI イベントの種類に応じて API リクエストを行いレスポンスから models のストリームを生成する
//        models = requestTrigger
//            .flatMapFirst { kind in
//                // 中略: API リクエスト
//                
//                
//            }
//            .startWith([])
//            .shareReplay(1)
//    }
    
}
