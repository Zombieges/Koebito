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

enum Kinds: Int {
    case crying
    case love
    case sulk
    case mad
    case encourage
    
    var KindName: String {
        switch self {
        case .crying:
            return "泣いてる系"
        case .love:
            return "甘える系"
        case .sulk:
            return "拗ねてる系"
        case .mad:
            return "怒ってる系"
        case .encourage:
            return "励まし系"
        }
    }
}
