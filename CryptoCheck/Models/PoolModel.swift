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
    var address: String?
    var api: MineProtocol?
    
    init(name: String, cryptoModel: CryptoModel, api: MineProtocol) {
        self.name = name
        self.cryptoModel = cryptoModel
        self.api = api
    }
    
    static let btcPools = [PoolModel]()
    static let ethPools = [
        PoolModel(name: "ethermine.org", cryptoModel: CryptoModel.eth, api: EthermineAPI()),
        PoolModel(name: "dwarfpool.com", cryptoModel: CryptoModel.eth, api: EthermineAPI())
    ]
    static let ltcPools = [PoolModel]()
    static let xmrPools = [PoolModel]()
    static let dashPools = [PoolModel]()
    static let pascPools = [PoolModel]()
    static let dcrPools = [
        PoolModel(name: "ethermine.org", cryptoModel: CryptoModel.eth, api: EthermineAPI())
    ]
    
    
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
