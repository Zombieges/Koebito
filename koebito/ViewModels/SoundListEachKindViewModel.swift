//
//  SoundListEachKindViewModel.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2018/01/05.
//  Copyright © 2018年 Zombieges. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SoundListEachKindViewModel {
    //var voices: Observable<[VoicesRespose]> = Observable.empty()
    private var voice: Voice?
    var voicesResponse: VoicesRespose? {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (()->())?
    func getVoices(with kind: Int) {
        let response = APIClient.shared.dataRequest(with: kind)
        _ = response.subscribe(
            onNext: { [weak self](res) in
                guard let weakSelf = self else {
                    return
                }
                print(res)
                // TODO: call getImagesAndSounds with res
                weakSelf.voicesResponse = res
        },
            onError: { (error) in
                print(error)
        })
    }
}
