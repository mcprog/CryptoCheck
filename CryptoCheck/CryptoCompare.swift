//
//  CryptoCompareUrl.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/6/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
class CryptoCompare {
    static let prefix: String = "https://min-api.cryptocompare.com/data/price"
    
    static func getUrl(from: String, to: String) -> String {
        return prefix + "?fsym=" + from + "&tsyms=" + to;
    }
    
    
}
