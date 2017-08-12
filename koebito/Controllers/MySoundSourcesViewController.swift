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
    @IBOutlet weak var soundsList: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
        // set up profileImageView
        let ProfileImageViewNib = ProfileImageView.instantiate(ownerOrNil: nil, options: nil)
        profileImage.addSubview(ProfileImageViewNib)
        // set up tableView
        let SoundsListTableViewNib = SoundsList.instantiate(ownerOrNil: nil, options: nil)
        soundsList.addSubview(SoundsListTableViewNib)
    }
}

