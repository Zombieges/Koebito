//
//  MySoundSourcesViewController
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/07/16.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit

class MySoundSourcesViewController: UIViewController {

    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var soundsListTableView: UITableView!
    @IBOutlet weak var addSound: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up profileImageView
        let ProfileImageViewNib = ProfileImageView.instantiate(ownerOrNil: nil, options: nil)
        profileImage.addSubview(ProfileImageViewNib)
        // set up addSound
        let addSoundViewNib = AddSound.instantiate(ownerOrNil: nil, options: nil)
        addSound.addSubview(addSoundViewNib)
    }
}

