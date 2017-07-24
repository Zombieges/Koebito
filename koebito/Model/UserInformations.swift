//
//  UserInformations.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/07/22.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import Foundation
import ObjectMapper

class UserInformations {
    var gender: Int?
    var name: String?
    var pictureUrl: String?
    
    // call mapping(map: Map) in initializer
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}

extension UserInformations: Mappable {
    
    func mapping(map: Map) {
        self.gender       <- map["gender"]
        self.name         <- map["name"]
        self.pictureUrl   <- map["pictureUrl"]
    }
}
