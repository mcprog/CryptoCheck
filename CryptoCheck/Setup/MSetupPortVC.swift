//
//  MSetupPortVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/8/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation

import UIKit

class MSetupPortVC: UITableViewController {
    
    var ports: [Int]?
    var selectedPort: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ports!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setupPortCell", for: indexPath) as? SetupPortCell
        let data = ports![indexPath.row]
        cell?.nameLabel.text = "\(data)"
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "unwindFromSetupPort") {
            let cell = sender as! SetupPortCell
            let index = tableView.indexPath(for: cell)
            if let indexPath = index?.row {
                selectedPort = ports?[indexPath]
            }
        }
    }
    
}
