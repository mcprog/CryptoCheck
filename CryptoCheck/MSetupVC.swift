//
//  MPageSetupVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/1/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MSetupVC: UITableViewController {
    
    @IBOutlet weak var iconCurrency: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var poolLabel: UILabel!
    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var portLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    var pools: [PoolModel]?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Utility.printUserDefaults()
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        if let suffix = defaults.string(forKey: "cryptoSuffix") {
            let model = CryptoModel.getCryptoModel(suffix: suffix)
            setCurrency(cryptoModel: model)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "showSetupCurrency", sender: self)
        case 1:
            performSegue(withIdentifier: "showSetupPool", sender: self)
        default:
            return
        }
        
    }
    
    func setCurrency(cryptoModel: CryptoModel) {
        iconCurrency.image = cryptoModel.icon
        let message = cryptoModel.getFullName();
        currencyLabel.text = message
        
        pools = PoolModel.getPools(suffix: cryptoModel.suffix)
    }
    
    func saveCurrency(cryptoModel: CryptoModel) {
        defaults.set(cryptoModel.suffix, forKey: "cryptoSuffix")
        //defaults.set(cryptoModel.name, forKey: "cryptoName")
        //defaults.set(cryptoModel.icon, forKey: "cryptoIcon")
        Utility.printUserDefaults()
    }
    
    func setPool(poolModel: PoolModel) {
        poolLabel.text = poolModel.name
    }
    
    func savePool(poolModel: PoolModel) {
        defaults.set(poolModel.name, forKey: "poolName")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mSetupPoolVC = segue.destination as? MSetupPoolVC {
            mSetupPoolVC.poolModels = pools
        }
    }
    
    @IBAction func unwindFromSetupCurrency(segue:UIStoryboardSegue) {
        let mSetupCurrencyVC = segue.source as? MSetupCurrencyVC
        if let selected = mSetupCurrencyVC?.selectedCurrency {
            setCurrency(cryptoModel: selected)
            //saveCurrency(cryptoModel: selected)
        }
    }
    
    @IBAction func unwindFromSetupPool(segue: UIStoryboardSegue) {
        let mSetupPoolVC = segue.source as? MSetupPoolVC
        if let selected = mSetupPoolVC?.selectedPool {
            setPool(poolModel: selected)
        }
    }
    
    
}
