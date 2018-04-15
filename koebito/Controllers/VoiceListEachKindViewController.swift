//
//  VoiceListEachKindViewController.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/07/17.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class VoiceListEachKindViewController: UIViewController {
    
    @IBOutlet weak var VoiceListTableView: UITableView!
    private let voiceListEachKindViewModel = VoiceListEachKindViewModel()

    var kind: Kinds?
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        guard let kind = self.kind?.rawValue else {
            return
        }
        voiceListEachKindViewModel.getVoices(with: kind)
    }

    func initVM() {
        voiceListEachKindViewModel.reloadTableViewClosure = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.VoiceListTableView.reloadData()
        }
    }
}

extension VoiceListEachKindViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voiceListEachKindViewModel.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "voiceListTableCell", for: indexPath) as! VoiceListCell

        let cellVM = voiceListEachKindViewModel.getVoiceCellViewModel(at: indexPath)
        cell.ownerImage.kf.setImage(with: cellVM.ownerImageUrl)
        cell.ownerName.text = cellVM.ownerName
        cell.voiceTitle.text = cellVM.voiceTitle
        return cell
    }
}
