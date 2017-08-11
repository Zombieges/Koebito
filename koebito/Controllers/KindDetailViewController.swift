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
    let STRef = Storage.storage().reference(forURL: "gs://~~~~")
    //typealias UsersResponse = [[String : AnyObject]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatestVoices().then(getImageUrl)
        
        
//        getVoices().then { voices in
//            print(voices)
//
//        }
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
    func getLatestVoices() -> Promise<[String]> {
        return Promise (in: .background, { resolve, reject in
            guard let kind = self.kind else {
                return
            }
            // TODO: orderby timestanp(desc)
            let defaultPlace = self.DBRef.child("voices").child(kind.rawValue)
            defaultPlace.observe(.value) { (snap: DataSnapshot) in
                if let voices = snap.value as? [[String : AnyObject]] {
                    
                    //let voices = Mapper<UserInformations>().mapArray(JSONArray: result)
                    //resolve(voices)
                    var soundUrls: [String] = []
                    for object in voices[0] {
                        if object.key == "soundUrl" {
                            soundUrls.append(object.value as! String)
                        }
                    }
                    print(voices)
                    resolve(soundUrls)
                }
            }
        })
    }
    func getImageUrl(soundUrls: [String]) -> Promise<[[String : AnyObject]]> {
        return Promise<[[String : AnyObject]]> (in: .background, { resolve, reject in

            // TODO:キャッシュ確認
            for url in soundUrls {
                //let defaultPlace = self.STRef.child(url)
                let defaultPlace = self.STRef.child("voices").child("001-sibutomo.mp3")
                defaultPlace.getData(maxSize: 1 * 1024 * 1024) { (data, error) -> Void in
                    if (error != nil) {
                        // Uh-oh, an error occurred!
                    } else {
                        // Data for "images/island.jpg" is returned
                        let islandImage: UIImage! = UIImage(data: data!)
                    }
                }
            }
        })
    }
}
