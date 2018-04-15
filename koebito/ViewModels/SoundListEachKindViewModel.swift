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
    let transferManager = AWSS3TransferManager.default()
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

                let downloadingFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("default.png")
                
                let downloadRequest = AWSS3TransferManagerDownloadRequest()
                
                downloadRequest?.bucket = "koebito/images"
                downloadRequest?.key = "default.png"
                downloadRequest?.downloadingFileURL = downloadingFileURL
                weakSelf.transferManager.download(downloadRequest!).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask<AnyObject>) -> Any? in
                    
                    if let error = task.error as? NSError {
                        if error.domain == AWSS3TransferManagerErrorDomain, let code = AWSS3TransferManagerErrorType(rawValue: error.code) {
                            switch code {
                            case .cancelled, .paused:
                                break
                            default:
                                print("Error downloading: \(downloadRequest?.key) Error: \(error)")
                            }
                        } else {
                            print("Error downloading: \(downloadRequest?.key) Error: \(error)")
                        }
                        return nil
                    }
                    print("Download complete for: \(downloadRequest?.key)")
                    let downloadOutput = task.result
                    return nil
                })
        },
            onError: { (error) in
                print(error)
        })
    }
    func getVoiceCellViewModel(at indexPath: IndexPath) -> VoicesRespose.Voice {
        return voiceList[indexPath.row]
    }
}
