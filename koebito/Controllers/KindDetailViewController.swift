//
//  KindDetailViewController.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/07/17.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit
import RxSwift

class KindDetailViewController: UIViewController {
    
    @IBOutlet weak var SoundListEachKindTableView: SoundListEachKindTableView!
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

