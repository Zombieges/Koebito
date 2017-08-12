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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up profileImageView
        let ProfileImageViewNib = ProfileImageView.instantiate(ownerOrNil: nil, options: nil)
        profileImage.addSubview(ProfileImageViewNib)
//        // set up tableView
//        let nib = UINib(nibName: "SoundsLiatTableViewCell", bundle: nil)
//        soundsListTableView.register(nib, forCellReuseIdentifier: "SoundsListCellIdentifier")
    }
    
    override func viewDidLayoutSubviews() {
        
    }
}

//
//extension MySoundSourcesViewController: UITableViewDataSource,
//                                        UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundsListCellIdentifier") as! SoundsLiatTableViewCell
//        cell.textLabel?.text = ""
//        return cell
//    }
//}
