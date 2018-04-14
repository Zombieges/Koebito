//
//  SoundListEachKindTableView.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2018/01/05.
//  Copyright © 2018年 Zombieges. All rights reserved.
//

import UIKit

class SoundListEachKindTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    private let viewModel = APIClient()
    private let soundListEachKindViewModel = SoundListEachKindViewModel()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "voiceListTableCell", for: indexPath) as? VoiceListCell

        //cell = soundListEachKindViewModel.getVoiceCellViewModel(at: indexPath).
        return cell!;
    }
}

class VoiceListCell: UITableViewCell {
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var voiceTitle: UILabel!
    @IBOutlet weak var voiceUrl: UILabel!
}
