//
//  MSetupPortVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/8/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation

import UIKit

class MSetupAddressNewVC: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var newAddress: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "unwindFromSetupAddressNew") {
            if let text = textField.text {
                newAddress = text
            }
            
        }
    }
    

    
}

extension MSetupAddressNewVC : UITextFieldDelegate {
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


