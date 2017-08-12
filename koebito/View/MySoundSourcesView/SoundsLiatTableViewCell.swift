//
//  SoundsLiatTableViewCell.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/08/13.
//  Copyright © 2017年 Kazuhiro Watanabe. All rights reserved.
//

import UIKit

class SoundsLiatTableViewCell: UITableViewCell {

    @IBOutlet weak var soundImage: UIImageView!
    @IBOutlet weak var soundList: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
