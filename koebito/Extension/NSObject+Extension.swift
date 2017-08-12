//
//  NSObject+Extension.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/08/13.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    var className: String {
        return type(of: self).className
    }
}
