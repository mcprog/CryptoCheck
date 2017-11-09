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
    var selectedPool: PoolModel?
    var selectedServer: ServerModel?
    
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
            if pools == nil {
                return
            }
            performSegue(withIdentifier: "showSetupPool", sender: self)
        case 2:
            if selectedPool == nil {
                return
            }
            performSegue(withIdentifier: "showSetupServer", sender: self)
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
    
    func clearCurrency() {
        iconCurrency.image = nil
        currencyLabel.text = "please select a currency"
    }
    
    func setPool(poolModel: PoolModel) {
        poolLabel.text = poolModel.name
        selectedPool = poolModel
    }
    
    func savePool(poolModel: PoolModel) {
        defaults.set(poolModel.name, forKey: "poolName")
    }
    
    func clearPool() {
        poolLabel.text = "please select a mining pool"
        selectedPool = nil
    }
    
    func setServer(serverModel: ServerModel) {
        serverLabel.text = serverModel.name
        selectedServer = serverModel
    }
    
    func saveServer(serverModel: ServerModel) {
        defaults.set(serverModel.name, forKey: "serverName")
    }
    
    func clearServer() {
        serverLabel.text = "please select a server"
        selectedServer = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mSetupPoolVC = segue.destination as? MSetupPoolVC {
            mSetupPoolVC.poolModels = pools
        }
        else if let mSetupServerVC = segue.destination as? MSetupServerVC {
            mSetupServerVC.serverModels = selectedPool?.servers
        }
    }
    
    @IBAction func unwindFromSetupCurrency(segue:UIStoryboardSegue) {
        let mSetupCurrencyVC = segue.source as? MSetupCurrencyVC
        if let selected = mSetupCurrencyVC?.selectedCurrency {
            setCurrency(cryptoModel: selected)
            clearPool()
            clearServer()
        }
    }
    
    @IBAction func unwindFromSetupPool(segue: UIStoryboardSegue) {
        let mSetupPoolVC = segue.source as? MSetupPoolVC
        if let selected = mSetupPoolVC?.selectedPool {
            setPool(poolModel: selected)
            clearServer()
        }
    }
    
    @IBAction func unwindFromSetupServer(segue: UIStoryboardSegue) {
        let mSetupServerVC = segue.source as? MSetupServerVC
        if let selected = mSetupServerVC?.selectedServer {
            setServer(serverModel: selected)
        }
    }
    
    
}
