//
//  SetupModel.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/12/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
struct SetupModel: Codable {
    var currencyIndex: Int
    var poolIndex: Int
    var address: String
    
    
    
    static func getObject() -> SetupModel? {
        if let object = UserDefaults.standard.value(forKey: "setup") as? Data {
            let decoder = JSONDecoder()
            if let objectDecoded = try? decoder.decode(SetupModel.self, from: object) as SetupModel {
                return objectDecoded
            }
        }
        return nil
    }
    
    static func saveObject(object: SetupModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            UserDefaults.standard.set(encoded, forKey: "setup")
        }
    }
    
}




