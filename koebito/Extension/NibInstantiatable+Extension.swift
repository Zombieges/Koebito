//
//  NibInstantiatable+Extension.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/08/12.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit

protocol NibInstantiatable {
    static var nibName: String { get }
    static func instantiate(ownerOrNil: AnyObject?, options: [NSObject: AnyObject]?) -> Self
}

extension NibInstantiatable where Self: UIView {
    static var nibName: String {
        get {
            // 「自分のクラス名の文字列」を返す
            return String(describing: Self.self)
        }
    }
    
    static func instantiate(ownerOrNil: AnyObject?, options: [NSObject: AnyObject]?) -> Self {
        // リテラル文字で記述すべき部分をココに共通化
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: ownerOrNil, options: options).first as! Self
    }
}
