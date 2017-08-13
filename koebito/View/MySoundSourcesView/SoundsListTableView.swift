//
//  SoundsListTableView.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/08/13.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit

class SoundsListTableView: UITableView,
                           UITableViewDataSource,
                           UITableViewDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        registerCell(type: SoundsLiatTableViewCell.self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Kinds.cases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Kinds.getKindName(rawValue: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(type: SoundsLiatTableViewCell.self, indexPath: indexPath)
        cell.textLabel?.text = ""
        return cell
    }
}
