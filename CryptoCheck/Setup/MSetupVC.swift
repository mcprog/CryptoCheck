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
    @IBOutlet weak var updateButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    var selectedCurrency: CryptoModel?
    var pools: [PoolModel]?
    var selectedPool: PoolModel?
    var selectedServer: ServerModel?
    var selectedPort: Int?
    var selectedAddress: String?
    
    var poolIndex = -1
    var serverIndex = -1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Utility.printUserDefaults()
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.setTitle("UPDATE", for: .normal)
        if let suffix = defaults.string(forKey: "cryptoSuffix") {
            let model = CryptoModel.getCryptoModel(suffix: suffix)
            setCurrency(cryptoModel: model)
            let pool = defaults.integer(forKey: "poolIndex")
           
            if (pool != 0) {
                let poolModel = pools![pool - 1]
                setPool(poolModel: poolModel)
                let server = defaults.integer(forKey: "serverIndex")
                if server != 0 {
                    let serverModel = selectedPool!.servers[server - 1]
                    setServer(serverModel: serverModel)
                    let port = defaults.integer(forKey: "port")
                    if (port != 0) {
                        setPort(port: port)
                    }
                }
            }
        }
        if let address = defaults.string(forKey: "address") {
            setAddress(address: address)
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
        selectedCurrency = cryptoModel
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
        pools = nil
        selectedCurrency = nil
    }
    
    func setPool(poolModel: PoolModel) {
        poolLabel.text = poolModel.name
        selectedPool = poolModel
    }
    
    func savePool(index: Int) {
        //defaults.set(poolModel.name, forKey: "poolName")
        defaults.set(index + 1, forKey: "poolIndex")
    }
    
    func clearPool() {
        poolLabel.text = "please select a mining pool"
        selectedPool = nil
        poolIndex = -1
    }
    
    func setServer(serverModel: ServerModel) {
        serverLabel.text = serverModel.name
        selectedServer = serverModel
    }
    
    func saveServer(index: Int) {
        //defaults.set(serverModel.name, forKey: "serverName")
        defaults.set(index + 1, forKey: "serverIndex")
    }
    
    func clearServer() {
        serverLabel.text = "please select a server"
        selectedServer = nil
    }
    
    func setPort(port: Int) {
        portLabel.text = "\(port)"
        selectedPort = port
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
        selectedAddress = address
    }
    
    func saveAddress(address: String) {
        defaults.set(address, forKey: "address")
    }
    
    func clearAddress() {
        addressLabel.text = "please select an address"
        selectedAddress = nil
    }
    
    func tryPoolAPICall() {
        
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
            updateButton.setTitle("MISSING FIELDS", for: .normal)
            return
        }
        
        
        if (selectedAddress == nil) {
            updateButton.setTitle("NO ADDRESS", for: .normal)
            return
        }
        
        updateButton.setTitle("UPDATING...", for: .normal)
        saveCurrency(cryptoModel: selectedCurrency!)
        savePool(index: poolIndex)
        saveServer(index: serverIndex)
        savePort(port: selectedPort!)
        saveAddress(address: selectedAddress!)
        updateButton.setTitle("UPDATED", for: .normal)
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
        updateButton.setTitle("UPDATE", for: .normal)
    }
    
    @IBAction func unwindFromSetupPool(segue: UIStoryboardSegue) {
        let mSetupPoolVC = segue.source as? MSetupPoolVC
        if let selected = mSetupPoolVC?.selectedPool {
            setPool(poolModel: selected)
            clearServer()
            clearPort()
        }
        if let index = mSetupPoolVC?.selectedIndex {
            poolIndex = index
        }
        updateButton.setTitle("UPDATE", for: .normal)
    }
    
    @IBAction func unwindFromSetupServer(segue: UIStoryboardSegue) {
        let mSetupServerVC = segue.source as? MSetupServerVC
        if let selected = mSetupServerVC?.selectedServer {
            setServer(serverModel: selected)
            clearPort()
        }
        if let index = mSetupServerVC?.selectedIndex {
            serverIndex = index
        }
        updateButton.setTitle("UPDATE", for: .normal)
    }
    
    @IBAction func unwindFromSetupPort(segue: UIStoryboardSegue) {
        let mSetupPortVC = segue.source as? MSetupPortVC
        if let selected = mSetupPortVC?.selectedPort {
            setPort(port: selected)
        }
        updateButton.setTitle("UPDATE", for: .normal)
    }
    
    @IBAction func unwindFromSetupAddress(segue: UIStoryboardSegue) {
        let mSetupAddressVC = segue.source as? MSetupAddressVC
        if let selected = mSetupAddressVC?.selectedAddress{
            setAddress(address: selected)
            
        }
        updateButton.setTitle("UPDATE", for: .normal)
    }
    
    
}
