//
//  Utility.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/7/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
class Utility {
    
    static func printUserDefaults() {
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
    }
    
    static func toMH(hash: Double) -> Double {
        return hash / 1000000
    }
    
    static func getAgo(date : Date) -> String {
        let now = Date()
        let seconds = now.timeIntervalSince(date)
        if (seconds < 60) {
            return "\(Int(seconds)) secs ago"
        }
        else if (seconds < 3600) {
            return "\(Int(seconds / 60)) mins ago"
        }
        else if (seconds < 86400) {
            return "\(Int(seconds / 3600)) hrs ago"
        } else {
            return "\(Int(seconds / 86400)) days ago"
        }
    }
    
}
