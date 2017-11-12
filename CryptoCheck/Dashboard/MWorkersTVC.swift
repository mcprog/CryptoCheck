//
//  MWorkersTVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/12/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MWorkersTVC: UITableViewController {
    
    var workers = [WorkerModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workerCell", for: indexPath) as? WorkerCell
        let data = workers[indexPath.row]
        cell?.nameLabel.text = data.name
        cell?.lastSeenLabel.text = Utility.getAgo(date: data.lastSeen!)
        cell?.rHashLabel.text = "\(String(format: "%.1f",  Utility.toMH(hash: data.reported!))) MH/s"
        cell?.cHashLabel.text = "\(String(format: "%.1f",  Utility.toMH(hash: data.current!))) MH/s"
        cell?.aHashLabel.text = "\(String(format: "%.1f",  Utility.toMH(hash: data.average!))) MH/s"
        cell?.validLabel.text = "\(data.validShares ?? -1)"
        cell?.invalidLabel.text = "\(data.invalidShares ?? -1)"
        cell?.staleLabel.text = "\(data.staleShares ?? -1)"
        
        
        return cell!
    }
}
