//
//  CryptoModel.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/6/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import UIKit

class CryptoModel {
    
    static let btc = CryptoModel.createCryptoModel(suffix: "BTC")
    static let eth = CryptoModel.createCryptoModel(suffix: "ETH")
    static let ltc = CryptoModel.createCryptoModel(suffix: "LTC")
    static let xmr = CryptoModel.createCryptoModel(suffix: "XMR")
    static let dash = CryptoModel.createCryptoModel(suffix: "DASH")
    static let pasc = CryptoModel.createCryptoModel(suffix: "PASC")
    static let dcr = CryptoModel.createCryptoModel(suffix: "DCR")
    
    var name: String
    var suffix: String
    var btcMult: Double?
    var icon: UIImage
    
    init(name: String, suffix: String, icon: UIImage) {
        self.name = name
        self.suffix = suffix
        self.icon = icon
    }
    
    func setBTCMult(btcMult: Double) -> Double {
        self.btcMult = btcMult
        return btcMult
    }
    
    func getFullName() -> String {
        return name + " (" + suffix + ")"
    }
    
    static func createCryptoModel(suffix: String) -> CryptoModel {
        switch suffix {
        case "BTC":
            return CryptoModel(name: "Bitcoin", suffix: "BTC", icon: #imageLiteral(resourceName: "btc_logo"))
        case "ETH":
            return CryptoModel(name: "Ethereum", suffix: "ETH", icon: #imageLiteral(resourceName: "eth_logo"))
        case "LTC":
            return CryptoModel(name: "Litecoin", suffix: "LTC", icon: #imageLiteral(resourceName: "ltc_logo"))
        case "XMR":
            return CryptoModel(name: "Monero", suffix: "XMR", icon: #imageLiteral(resourceName: "xmr_logo"))
        case "DASH":
            return CryptoModel(name: "DigitalCash", suffix: "DASH", icon: #imageLiteral(resourceName: "dash_logo"))
        case "PASC":
            return CryptoModel(name: "Pascal", suffix: "PASC", icon: #imageLiteral(resourceName: "pasc_logo"))
        default:
            return CryptoModel(name: "Decred", suffix: "DCR", icon: #imageLiteral(resourceName: "decred_logo"))
        }
    }
    
    static func getCryptoModel(suffix: String) -> CryptoModel {
        switch suffix {
        case "BTC":
            return btc
        case "ETH":
            return eth
        case "LTC":
            return ltc
        case "XMR":
            return xmr
        case "DASH":
            return dash
        case "PASC":
            return pasc
        default:
            return dcr
        }
    }
    
    static func getCoins() -> [CryptoModel] {
        return [btc, eth, ltc, xmr, dash, pasc, dcr]
    }
}
