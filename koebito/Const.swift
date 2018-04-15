//
//  Const.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/07/17.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import Foundation
import UIKit

// 端末の幅
var viewFrameWidth: CGFloat?

// KindViewController 用の height （todo enum に変更する）
var viewFrameHeight: CGFloat? {
    guard let viewFrameWidth = viewFrameWidth else {
        return nil
    }
    return viewFrameWidth*1.7
}

// Cell 内に表示させる画像、ラベルのポジション
var displayIncellPosition: CGFloat? {
    guard let viewFrameWidth = viewFrameWidth else {
        return nil
    }
    return viewFrameWidth/4-2
}

// KindViewController 用の cellSize（todo enum に変更する）
var cellSize: CGFloat? {
    guard let viewFrameWidth = viewFrameWidth else {
        return nil
    }
    return viewFrameWidth/2-1
}

enum Kinds: Int, EnumEnumerable {
    case crying
    case love
    case sulk
    case mad
    case encourage
    
    var KindName: String {
        switch self {
        case .crying:
            return "crying"
        case .love:
            return "love"
        case .sulk:
            return "sulk"
        case .mad:
            return "mad"
        case .encourage:
            return "encourage"
        }
    }
    
    var image: UIImage? {
        return UIImage(named: KindName)
    }
}

enum SerialQueue: String {
    case kingFisherTaskQueue

    private static var pool = [String: DispatchGroup]()
    var queue: DispatchQueue {
        return DispatchQueue(label: label)
    }
    var group: DispatchGroup {
        if let group = SerialQueue.pool[self.rawValue] {
            return group
        }
        let group = DispatchGroup()
        SerialQueue.pool[self.rawValue] = group
        return group
    }
    private var label: String {
        return rawValue
    }
}
