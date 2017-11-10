//
//  MSetupPoolVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/7/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MSetupPoolVC: UITableViewController {
    
    var poolModels: [PoolModel]?
    var poolNames = [String]()
    var selectedPool: PoolModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(poolModels)
        for pool in poolModels! {
            poolNames.append(pool.name)
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poolNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setupPoolCell", for: indexPath) as? SetupPoolCell
        let data = poolNames[indexPath.row]
        cell?.nameLabel.text = data
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "unwindFromSetupPool") {
            let cell = sender as! SetupPoolCell
            let index = tableView.indexPath(for: cell)
            if let indexPath = index?.row {
                selectedPool = poolModels?[indexPath]
            }
        }
        
    }
}
