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

class KindDetailViewController: UIViewController {
    
    let DBRef = Database.database().reference()
    typealias UsersResponse = [[String : AnyObject]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchUsersInfo = Promise<UsersResponse> { resolve, reject in
            
            let defaultPlace = self.DBRef.child("voices")
            defaultPlace.observe(.value) { (snap: DataSnapshot) in
                //resolove(JSON(snap.value! as AnyObject))
                if let result = snap.value as? UsersResponse {
                    resolve(result)
                }
            }
        }.then { result in
            // 画面表示処理
            print(result)
            
            //let user = UserListsRequset(map: result)
            print(type(of: result))
            
            //let user = UserListsRequset(JSON: result)
            //let user = Mapper<UserListsRequset>().map
            //let user = Mapper<UserListsRequset>().mapArray(JSONArray: result)
            //let jsonjj = "{\"gender\":1,\"userName\":\"aaaaa\"}"
            //let user = UserListsRequset(JSONString: jsonjj)
            
            print("aa")
        }
    }
}
