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
import SwiftyJSON

class KindDetailViewController: UIViewController {
    
    var kind: Kinds?
    let DBRef = Database.database().reference()
    //typealias UsersResponse = [[String : AnyObject]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVoices().then { voices in
            print(voices)
            for object in voices[0] {
                if object.key == "ownerId" {
                    self.getImageUrl(OwnerIageUrl: object.value as! Int).then { users in
                        print(users)
                    }
                }
            }
        }
        /// fethch user infomations
//        let getVoices:  Promise<[[String : AnyObject]]>
//        Promise<[[String : AnyObject]]> { resolve, reject in
//            
//
//            let defaultPlace = self.DBRef.child("voices").child(kind.rawValue)
//            defaultPlace.observe(.value) { (snap: DataSnapshot) in
//                if let voices = snap.value as? [[String : AnyObject]] {
//                    
//                    //let voices = Mapper<UserInformations>().mapArray(JSONArray: result)
//                    resolve(voices)
//                }
//            }
//        }.then { voices -> [[String : AnyObject]] in
//            
//            /// check if the url of pictures are chenged
//            
//            let defaultPlace = self.DBRef.child("users").child(kind.rawValue)
//            defaultPlace.observe(.value) { (snap: DataSnapshot) in
//                if let voices = snap.value as? [[String : AnyObject]] {
//                    
//                    //let voices = Mapper<UserInformations>().mapArray(JSONArray: result)
//                    resolve(voices)
//                }
//            }
//        }
    }
    func getVoices() -> Promise<[[String : AnyObject]]> {
        return Promise<[[String : AnyObject]]> (in: .background, { resolve, reject in
            guard let kind = self.kind else {
                return
            }
            let defaultPlace = self.DBRef.child("voices").child(kind.rawValue)
            defaultPlace.observe(.value) { (snap: DataSnapshot) in
                if let voices = snap.value as? [[String : AnyObject]] {
                    
                    //let voices = Mapper<UserInformations>().mapArray(JSONArray: result)
                    resolve(voices)
                }
            }
        })
    }
    func getImageUrl(OwnerIageUrl: Int) -> Promise<[[String : AnyObject]]> {
        return Promise<[[String : AnyObject]]> (in: .background, { resolve, reject in

            let defaultPlace = self.DBRef.child("users").child(String(OwnerIageUrl))
            defaultPlace.observe(.value) { (snap: DataSnapshot) in
                if let users = snap.value as? [[String : AnyObject]] {
                    
                    //let voices = Mapper<UserInformations>().mapArray(JSONArray: result)
                    resolve(users)
                }
            }
        })
    }
}
