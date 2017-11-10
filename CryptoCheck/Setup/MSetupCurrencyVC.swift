//
//  MSetupCurrencyVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/6/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit

class MSetupCurrencyVC: UITableViewController {
    
    
    
    let coins = CryptoModel.getCoins()
    
    
    var selectedCurrency: CryptoModel?
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        for coin in coins {
            let urlString = URL(string: CryptoCompare.getUrl(from: coin.suffix, to: "USD"))
            if let url = urlString {
                let task = URLSession.shared.dataTask(with: url) {
                    (data, response, error) in
                    if (error != nil) {
                        print(error)
                    } else {
                        if let usableData = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: usableData, options: []) as? [String : Any]
                                coin.btcMult = json!["USD"] as? Double
                            } catch {
                                print("Couldn't parse JSON")
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "unwindFromSetupCurrency") {
            let cell = sender as! SetupCurrencyCell
            let index = tableView.indexPath(for: cell)
            if let indexPath = index?.row {
                selectedCurrency = coins[indexPath]
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setupCurrencyCell", for: indexPath) as? SetupCurrencyCell
        let data = coins[indexPath.row]
        cell?.nameLabel.text = data.name + " (" + data.suffix + ")"
        cell?.iconView.image = data.icon
        return cell!
    }
    
}
