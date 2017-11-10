//
//  MSetupPortVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/8/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation

import UIKit

class MSetupAddressVC: UITableViewController {
    
    var addresses = [String]()
    var selectedAddress: String?
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let addrs = defaults.array(forKey: "addresses") {
            addresses = addrs as! [String]
        }
        tableView.reloadData()
    }
    
    func saveAddresses() {
        defaults.set(addresses, forKey: "addresses")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setupAddressCell", for: indexPath) as? SetupAddressCell
        let data = addresses[indexPath.row]
        cell?.nameLabel.text = data
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "unwindFromSetupAddress") {
            let cell = sender as! SetupAddressCell
            let index = tableView.indexPath(for: cell)
            if let indexPath = index?.row {
                selectedAddress = addresses[indexPath]
            }
        }
    }
    
    @IBAction func unwindFromSetupAddressNew(segue: UIStoryboardSegue) {
   
        let mSetupAddressNewVC = segue.source as? MSetupAddressNewVC
        if let selected = mSetupAddressNewVC?.newAddress {
            addresses.append(selected)
            tableView.reloadData()
            saveAddresses()
        }
    }
    
}

