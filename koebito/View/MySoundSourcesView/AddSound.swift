//
//  AddSound.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/08/13.
//
//

import UIKit

final class AddSound: UIView, NibInstantiatable {

    @IBOutlet weak var addSound: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //let tap = UITapGestureRecognizer(target(forAction: #selector(self.addsoundTapHunbler), withSender: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddSound.addsoundTapHunbler))
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
    }
    
    @objc func addsoundTapHunbler() {
        // TODo: nabe 音楽登録画面へ遷移する
    }
}
