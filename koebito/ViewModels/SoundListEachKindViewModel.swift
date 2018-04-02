//
//  SoundListEachKindViewModel.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2018/01/05.
//  Copyright © 2018年 Zombieges. All rights reserved.
//

import Foundation
import RxSwift

class SoundListEachKindViewModel {
    enum Result {
        case success(String)
        case failure(String)
    }
    
    var voices = [VoicesRespose]()
    
    func getVoices(kind: Int) {
        let response = APIClient.shared.dataRequest(kind: kind)
        _ = response.subscribe(
            onNext: { (res) in
                print(res)
                
        },
            onError: { (error) in
                print(error)
        })
    }
}
