//
//  PayoutModel.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/12/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
class PayoutModel {
    
    let date: Date
    let amount: UInt64
    
    init(date: Date, amount: UInt64) {
        self.date = date
        self.amount = amount
    }
    
}
