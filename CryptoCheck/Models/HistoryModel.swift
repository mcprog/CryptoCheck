//
//  HistoryModel.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/12/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
class HistoryModel {
    let date: Date
    let reported: Double
    let average: Double
    let current: Double
    
    init(date: Date, reported: Double, average: Double, current: Double) {
        self.date = date
        self.reported = reported
        self.average = average
        self.current = current
    }
    
    
    
}
