//
//  PoolModel.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/7/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
class PoolModel {
    
    var name: String
    var cryptoModel: CryptoModel
    var servers: [ServerModel]
    var selectedServerIndex: Int?
    var address: String?
    
    init(name: String, cryptoModel: CryptoModel, servers: [ServerModel]) {
        self.name = name
        self.cryptoModel = cryptoModel
        self.servers = servers
    }
    
    static let btcPools = [PoolModel]()
    static let ethPools = [
        PoolModel(name: "ethermine.org", cryptoModel: CryptoModel.eth, servers: [
            ServerModel(name: "us1.ethermine.org", ports: [4444, 1444]),
            ServerModel(name: "us2.ethermine.org", ports: [4444, 1444]),
            ServerModel(name: "eu1.ethermine.org", ports: [4444, 1444]),
            ServerModel(name: "asia1.ethermine.org", ports: [4444, 1444])
        ]),
        PoolModel(name: "nanopool.org", cryptoModel: CryptoModel.eth, servers: [
            ServerModel(name: "eth-eu1.nanopool.org", ports: [9999]),
            ServerModel(name: "eth-eu2.nanopool.org", ports: [9999]),
            ServerModel(name: "eth-us-east1.nanopool.org", ports: [9999]),
            ServerModel(name: "eth-us-west1.nanopool.org", ports: [9999]),
            ServerModel(name: "eth-asia1.nanopool.org", ports: [9999])
        ])
    ]
    static let ltcPools = [PoolModel]()
    static let xmrPools = [PoolModel]()
    static let dashPools = [PoolModel]()
    static let pascPools = [PoolModel]()
    static let dcrPools = [PoolModel]()
    
    
    static func getPools(suffix: String) -> [PoolModel] {
        switch suffix {
        case "BTC":
            return btcPools
        case "ETH":
            return ethPools
        case "LTC":
            return ltcPools
        case "XMR":
            return xmrPools
        case "DASH":
            return dashPools
        case "PASC":
            return pascPools
        default:
            return dcrPools
        }
    }
}
