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
import AWSS3
import Kingfisher

class SoundListEachKindViewModel {
    private var voiceList = [VoicesRespose.Voice]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (()->())?
//    private func setVoices(voices: [VoicesRespose.Voice]) {
//        var voiceVms = [Voice]()
//        for voice in voices {
//            voiceVms.append(Voice(ownerId: voice.ownerId,
//                                  ownerName: voice.userName,
//                                  title: voice.title,
//                                  kind: voice.kind,
//                                  voiceUrl: voice.soundUrl,
//                                  ownerImageUrl: voice.ownerImageUrl))
//        }
//    }
    func getVoices(with kind: Int) {
        let response = APIClient.shared.dataRequest(with: kind)
        _ = response.subscribe(
            onNext: { [weak self](res) in
                guard let weakSelf = self, let res = res else {
                    return
                }
                print(res)
                // getImage()
                weakSelf.voiceList = res.voices
        },
            onError: { (error) in
                print(error)
        })
    }
    func getVoiceCellViewModel(at indexPath: IndexPath) -> VoicesRespose.Voice {
        return voiceList[indexPath.row]
    }
}
