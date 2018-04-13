//
//  VoicesRespose.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/10/21.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

struct VoicesRespose: Codable {
    let error: Bool
    let message: String
    let voices: [Voice]
    
    struct Voice: Codable {
        let kind: Int
        let ownerId: String
        let soundUrl: String
        let title: String
        let userId: String
        let userName: String
        let imageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case kind
            case ownerId
            case soundUrl
            case title
            case userId
            case userName
            case imageUrl
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case voices = "Voices"
    }
}
