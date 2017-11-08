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
import SwiftyJSON
import Alamofire
import RxSwift

class KindDetailViewController: UIViewController {
    
    var kind: Kinds?
    let DBRef = Database.database().reference()
    //let STRef = Storage.storage().reference(forURL: "gs://~~~~")
    let STRef = Storage.storage().reference()
    //typealias UsersResponse = [[String : AnyObject]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let rawValue = self.kind?.rawValue else {
            return
        }
        let api = APISetting.getVoicesWithKinds(
            kind: rawValue
        )
        let request: Observable<Any> = APIClient.shared.dataRequest(api: api)
        // request.concat(TaskB)
        
        request.subscribe(
            onNext: { (res) in
                print(res)
        },
            onError: { (error) in
                print(error)
        })
//
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
        return Promise<[String]> (in: .background, { resolve, reject, _ in
            guard let rawValue = self.kind?.rawValue else {
                return
            }
            let parameters: Parameters = ["kind": rawValue]
            Alamofire.request("https://koebito-api.herokuapp.com/api/voices", parameters: parameters).responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result

                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                    resolve([utf8Text])
                }
            }
        })
    }
    func getImageUrl(soundUrls: [String]) -> Promise<[[String : AnyObject]]> {
        return Promise<[[String : AnyObject]]> (in: .background, { resolve, reject, _ in

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
