//
//  ServerModel.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/7/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
class ServerModel {
    var name: String
    var ports: [Int]
    var selectedPortIndex: Int?
    
    init(name: String, ports: [Int]) {
        self.name = name;
        self.ports = ports;
    }
}
