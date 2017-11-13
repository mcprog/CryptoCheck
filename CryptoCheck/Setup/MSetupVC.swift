//
//  MPageSetupVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/1/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MSetupVC: TabBarChildTVC {
    
    @IBOutlet weak var iconCurrency: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var poolLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    var selectedCurrency: CryptoModel?
    var pools: [PoolModel]?
    var selectedPool: PoolModel?
    var selectedAddress: String?
    var currentSetup: SetupModel?
    
    var currencyIndex = -1
    var poolIndex = -1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let setup = SetupModel.getObject() {
            print(setup)
            setCurrency(cryptoModel: CryptoModel.getCoins()[setup.currencyIndex])
            setPool(poolModel: pools![setup.poolIndex])
            setAddress(address: setup.address)
            setSetup(setup: setup)
            setButton(title: "LOAD")
        } else {
            setButton(title: "UPDATE")
        }
        Utility.printUserDefaults()
        
        
        
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
            performSegue(withIdentifier: "showSetupAddress", sender: self)
        default:
            return
        }
        
    }
    
    func setButton(title: String) {
        updateButton.setTitle(title, for: .normal)
    }
    
    func setSetup(setup: SetupModel) {
        currentSetup = setup
        currencyIndex = setup.currencyIndex
        poolIndex = setup.poolIndex
        print("cI: \(currencyIndex), pI \(poolIndex)")
    }
    
    func saveSetup(setup: SetupModel) {
        SetupModel.saveObject(object: setup)
    }
    
    func setCurrency(cryptoModel: CryptoModel) {
        iconCurrency.image = cryptoModel.icon
        let message = cryptoModel.getFullName();
        currencyLabel.text = message
        
        pools = PoolModel.getPools(suffix: cryptoModel.suffix)
        selectedCurrency = cryptoModel
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
    

    
    func clearPool() {
        poolLabel.text = "please select a mining pool"
        selectedPool = nil
        poolIndex = -1
    }
    
    func setAddress(address: String) {
        addressLabel.text = address
        selectedAddress = address
    }
    

    
    func clearAddress() {
        addressLabel.text = "please select an address"
        selectedAddress = nil
    }
    
    func tryPoolAPICall() {
        print("trying new api call")
        let api = selectedPool?.api
        api?.workers(setup: currentSetup!, tabBarVC: tabBarController!, button: updateButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mSetupPoolVC = segue.destination as? MSetupPoolVC {
            mSetupPoolVC.poolModels = pools
        }
    }
    
    @IBAction func updateTouched(_ sender: Any) {
        
        if (selectedPool == nil) {
            updateButton.setTitle("MISSING FIELDS", for: .normal)
            return
        }
        
        
        if (selectedAddress == nil) {
            updateButton.setTitle("NO ADDRESS", for: .normal)
            return
        }
        
        updateButton.setTitle("UPDATING...", for: .normal)
        tabBarController?.tabBar.items![1].isEnabled = false
        tabBarController?.tabBar.items![2].isEnabled = false
        let setup = SetupModel(currencyIndex: currencyIndex, poolIndex: poolIndex, address: selectedAddress!)
        print("final setup:")
        print(setup)
        setSetup(setup: setup)
        SetupModel.saveObject(object: currentSetup!)
        tryPoolAPICall()
    }
    
    @IBAction func unwindFromSetupCurrency(segue:UIStoryboardSegue) {
        
        let mSetupCurrencyVC = segue.source as? MSetupCurrencyVC
        if let selected = mSetupCurrencyVC?.selectedCurrency {
            setCurrency(cryptoModel: selected)
            
            clearPool()
            clearAddress()
        }
        if let selectedIndex = mSetupCurrencyVC?.selectedIndex {
            currencyIndex = selectedIndex
        }
        updateButton.setTitle("UPDATE", for: .normal)
    }
    
    @IBAction func unwindFromSetupPool(segue: UIStoryboardSegue) {
        let mSetupPoolVC = segue.source as? MSetupPoolVC
        if let selected = mSetupPoolVC?.selectedPool {
            setPool(poolModel: selected)
       
        }
        if let index = mSetupPoolVC?.selectedIndex {
            poolIndex = index
        }
        updateButton.setTitle("UPDATE", for: .normal)
    }
    
    @IBAction func unwindFromSetupServer(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindFromSetupPort(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindFromSetupAddress(segue: UIStoryboardSegue) {
        let mSetupAddressVC = segue.source as? MSetupAddressVC
        if let selected = mSetupAddressVC?.selectedAddress{
            setAddress(address: selected)
            
        }
        updateButton.setTitle("UPDATE", for: .normal)
    }
    
    
}
