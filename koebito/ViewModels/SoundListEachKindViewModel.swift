//
//  SoundListEachKindViewModel.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2018/01/05.
//  Copyright © 2018年 Zombieges. All rights reserved.
//

import RxSwift
import RxCocoa
import AWSS3

class SoundListEachKindViewModel {
    let transferManager = AWSS3TransferManager.default()
    private var voiceList = [VoiceListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (()->())?
    var completionHandler: ((_ vms: [VoiceListCellViewModel])->())?
    func getVoices(with kind: Int) {
        let response = APIClient.shared.dataRequest(with: kind)
        _ = response.subscribe(
            onNext: { [weak self](res) in
                guard let weakSelf = self, let res = res else {
                    return
                }
                print(res)
                var vms = [VoiceListCellViewModel]()
                for voice in res.voices {
                    vms.append(VoiceListCellViewModel(ownerImageUrl: URL(string:  voice.imageUrl)!,
                                                      ownerName: voice.userName,
                                                      voiceTitle: voice.title,
                                                      voiceUrl: voice.soundUrl))
                }
                weakSelf.voiceList = vms
//                let downloadingFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("default.png")
//
//                let downloadRequest = AWSS3TransferManagerDownloadRequest()!
//
//                downloadRequest.bucket = "koebito/images"
//                downloadRequest.key = "default.png"
//                downloadRequest.downloadingFileURL = downloadingFileURL
//                weakSelf.transferManager.download(downloadRequest).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask<AnyObject>) -> Any? in
//
//                    if let error = task.error as NSError? {
//                        if error.domain == AWSS3TransferManagerErrorDomain, let code = AWSS3TransferManagerErrorType(rawValue: error.code) {
//                            switch code {
//                            case .cancelled, .paused:
//                                break
//                            default:
//                                print("Error downloading: \(String(describing: downloadRequest.key)) Error: \(error)")
//                            }
//                        } else {
//                            print("Error downloading: \(String(describing: downloadRequest.key)) Error: \(error)")
//                        }
//                        return nil
//                    }
//                    print("Download complete for: \(String(describing: downloadRequest.key))")
//                    let _ = task.result
//                    return nil
//                })
        },
            onError: { (error) in
                print(error)
        })
    }
    func getVoiceCellViewModel(at indexPath: IndexPath) -> VoiceListCellViewModel {
        return voiceList[indexPath.row]
    }
    func getNumberOfCells() -> Int {
        return voiceList.count
    }
}

struct VoiceListCellViewModel {
    let ownerImageUrl: URL
    let ownerName: String
    let voiceTitle: String
    let voiceUrl: String
}
