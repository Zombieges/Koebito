//
//  SoundListEachKindTableView.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2018/01/05.
//  Copyright © 2018年 Zombieges. All rights reserved.
//

import UIKit

class SoundListEachKindTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    private let viewModel = APIClient()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //newCell.textLabel?.text = items[indexPath.row]
        return newCell;
    }
}
