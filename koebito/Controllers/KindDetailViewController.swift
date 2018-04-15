//
//  KindDetailViewController.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/07/17.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class KindDetailViewController: UIViewController {
    
    @IBOutlet weak var SoundListEachKindTableView: UITableView!
    private let soundListEachKindViewModel = SoundListEachKindViewModel()

    var kind: Kinds?
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        guard let kind = self.kind?.rawValue else {
            return
        }
        soundListEachKindViewModel.getVoices(with: kind)
    }

    func initVM() {
        soundListEachKindViewModel.reloadTableViewClosure = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.SoundListEachKindTableView.reloadData()
        }
    }
}

extension KindDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundListEachKindViewModel.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "voiceListTableCell", for: indexPath) as! VoiceListCell
        
        let cellVM = soundListEachKindViewModel.getVoiceCellViewModel(at: indexPath)
        cell.ownerImage.kf.setImage(with: cellVM.ownerImageUrl)
        cell.ownerName.text = cellVM.ownerName
        cell.voiceTitle.text = cellVM.voiceTitle
        
        return cell
    }
}
