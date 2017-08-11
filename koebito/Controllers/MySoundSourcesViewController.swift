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

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        let ProfileImageViewNib = UINib(nibName: "ProfileImageView", bundle: nil).instantiate(withOwner: self, options: nil).first as? ProfileImageView
        self.view.addSubview(ProfileImageViewNib!)
        //profileImage.addSubview(ProfileImageViewNib!)
    }
}

