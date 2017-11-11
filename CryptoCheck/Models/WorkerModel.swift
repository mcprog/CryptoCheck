//
//  WorkerModel.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/9/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation

class WorkerModel {
    var name: String?
    var lastSeen: Date?
    var reported: Double?
    var current: Double?
    var average: Double?
    var validShares: Int?
    var invalidShares: Int?
    var staleShares: Int?
    
    init(name: String, reported: Double, current: Double, average: Double, validShares: Int, invalidShares: Int, staleShares: Int) {
        self.name = name
        self.reported = reported
        self.current = current
        self.average = average
        self.validShares = validShares
        self.invalidShares = invalidShares
        self.staleShares = staleShares
    }
}

extension WorkerModel: CustomStringConvertible {
    var description: String {
        return "WorkerModel: " + name! + " (\(type(of: name!)))\n\t-reported: \(reported!)\n\t-current: \(current!)\n\t-average: \(average!)\n\t-valid: \(validShares!)\n\t-invalid: \(invalidShares!)\n\t-stale: \(staleShares!)"
    }
}


