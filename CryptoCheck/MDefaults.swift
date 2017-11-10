//
//  MDefaults.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/9/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation

class MDefaults : UserDefaults {
    override func integer(forKey defaultName: String) -> Int {
       return -1
    }
}
