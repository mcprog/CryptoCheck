//
//  MineModel.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/9/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
class MineModel {
    var workers: [WorkerModel]?
    var lastSeen: Date?
    var reported: Double?
    var current: Double?
    var average: Double?
    var api: MineProtocol?
    var address: String?
    
    init(reported: Double, current: Double, average: Double, workers: [WorkerModel]) {
        self.reported = reported
        self.current = current
        self.average = average
        self.workers = workers
    }
}

extension MineModel : CustomStringConvertible {
    var description: String {
        return  "MineModel:\n\t-workers: \(workers!.count)\n\t-reported: \(reported!)\n\t-current: \(current!)\n\t-average: \(average!)\n\t-address: \(address!)"
    }
    
    
    
}
