//
//  UITableView+Extension.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/08/13.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(type: T.Type){
        let className = type.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    
}
