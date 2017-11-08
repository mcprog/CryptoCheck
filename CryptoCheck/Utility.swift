//
//  Utility.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/7/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
class Utility {
    
    static func printUserDefaults() {
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
    }
    
}
