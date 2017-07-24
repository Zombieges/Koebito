//
//  KindDetailViewController.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/07/17.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit
import Hydra
import Firebase
import ObjectMapper

class KindDetailViewController: UIViewController {
    
    var kind: Kinds?
    let DBRef = Database.database().reference()
    //typealias UsersResponse = [[String : AnyObject]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// fethch user infomations
        Promise<[UserInformations]> { resolve, reject in
            
            let defaultPlace = self.DBRef.child("voices")
            defaultPlace.observe(.value) { (snap: DataSnapshot) in
                if let result = snap.value as? [[String : AnyObject]] {
                    
                    let users = Mapper<UserInformations>().mapArray(JSONArray: result)
                    resolve(users)
                }
            }
            
        }.then { result in
            
            /// check if the url of pictures are chenged
            print(result)
        }
    }
}
