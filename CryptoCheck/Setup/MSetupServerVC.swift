//
//  MSetupServerVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/8/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit

class MSetupServerVC: UITableViewController {
    
    var serverModels: [ServerModel]?
    var selectedServer: ServerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (serverModels?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setupServerCell", for: indexPath) as? SetupServerCell
        let data = serverModels![indexPath.row]
        cell?.nameLabel.text = data.name
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "unwindFromSetupServer") {
            let cell = sender as! SetupServerCell
            let index = tableView.indexPath(for: cell)
            if let indexPath = index?.row {
                selectedServer = serverModels?[indexPath]
            }
        }
    }
    
}
