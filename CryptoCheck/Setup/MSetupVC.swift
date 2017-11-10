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
    var selectedPort: Int?
    var selectedAddress: String?
    
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
        case 3:
            if selectedServer == nil {
                return
            }
            performSegue(withIdentifier: "showSetupPort", sender: self)
        case 4:
            performSegue(withIdentifier: "showSetupAddress", sender: self)
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
    
    func setPort(port: Int) {
        portLabel.text = "\(port)"
    }
    
    func savePort(port: Int) {
        defaults.set(port, forKey: "port")
    }
    
    func clearPort() {
        portLabel.text = "please select a port"
        selectedPort = nil
    }
    
    func setAddress(address: String) {
        addressLabel.text = address
    }
    
    func saveAddress(address: String) {
        defaults.set(address, forKey: "address")
    }
    
    func clearAddress() {
        addressLabel.text = "please select an address"
        selectedAddress = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mSetupPoolVC = segue.destination as? MSetupPoolVC {
            mSetupPoolVC.poolModels = pools
        }
        else if let mSetupServerVC = segue.destination as? MSetupServerVC {
            mSetupServerVC.serverModels = selectedPool?.servers
        }
        else if let mSetupPortVC = segue.destination as? MSetupPortVC {
            mSetupPortVC.ports = selectedServer?.ports
        }
    }
    
    @IBAction func updateTouched(_ sender: Any) {
        if (selectedPort == nil) {
            return
        }
        
        if (selectedAddress == nil) {
            return
        }
        
        
        
    }
    
    @IBAction func unwindFromSetupCurrency(segue:UIStoryboardSegue) {
        let mSetupCurrencyVC = segue.source as? MSetupCurrencyVC
        if let selected = mSetupCurrencyVC?.selectedCurrency {
            setCurrency(cryptoModel: selected)
            clearPool()
            clearServer()
            clearPort()
            clearAddress()
        }
    }
    
    @IBAction func unwindFromSetupPool(segue: UIStoryboardSegue) {
        let mSetupPoolVC = segue.source as? MSetupPoolVC
        if let selected = mSetupPoolVC?.selectedPool {
            setPool(poolModel: selected)
            clearServer()
            clearPort()
        }
    }
    
    @IBAction func unwindFromSetupServer(segue: UIStoryboardSegue) {
        let mSetupServerVC = segue.source as? MSetupServerVC
        if let selected = mSetupServerVC?.selectedServer {
            setServer(serverModel: selected)
            clearPort()
        }
    }
    
    @IBAction func unwindFromSetupPort(segue: UIStoryboardSegue) {
        let mSetupPortVC = segue.source as? MSetupPortVC
        if let selected = mSetupPortVC?.selectedPort {
            setPort(port: selected)
        }
    }
    
    @IBAction func unwindFromSetupAddress(segue: UIStoryboardSegue) {
        let mSetupAddressVC = segue.source as? MSetupAddressVC
        if let selected = mSetupAddressVC?.selectedAddress{
            setAddress(address: selected)
            
        }
    }
    
    
}
