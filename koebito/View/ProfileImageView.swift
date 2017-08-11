//
//  ProfileImageView.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/08/11.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit

class ProfileImageView: UIView {

    @IBOutlet weak var profileImage: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadXib()
    }
    private func loadXib() {
//        Bundle.main.loadNibNamed("ProfileImageView", owner: self, options: nil)
//        profileImage.frame = CGRect(x: 0,y: 0,width: frame.size.width,height: frame.size.height)
//        addSubview(profileImage)
    }
}
