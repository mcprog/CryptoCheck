//
//  DwarfpoolEthAPI.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 12/7/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit

struct DwarfpoolEthAPI: MineProtocol {
    func workers(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton) {
        "http://dwarfpool.com/eth/api?wallet=YOUR_WALLET"
        let baseUrl = "https://dwarfpool.com/eth/api?wallet="
        let workerUrlString = URL(string: baseUrl + setup.address + "&email=mail@example.com")
        
        if let workerUrl = workerUrlString {
            let workerTask = URLSession.shared.dataTask(with: workerUrl) {
                (data, response, error) in
                if (error != nil) {
                    print(error)
                } else {
                    if let usableData = data {
                        do {
                            var workers = [WorkerModel]()
                            let json = try JSONSerialization.jsonObject(with: usableData, options: []) as? [String : Any]
                            //let array = try json!["data"] as? [[String : Any]]
                            print(json!)
                            let array = try json!["data"] as? [[String : Any]]
                            print(array![0])
                            
                            for (key, val) in array!.enumerated() {
                                if let reported = val["hasrate"] as? Double {
                                    print(reported)
                                }
                                else {
                                    print("failed your country")
                                }
                                //let reported = el["hashrate"] as? Double
                                //let average = reported
                                //let calculated = el["hashrate_calculated"] as? Double
                                //print(calculated)
                            }
                            //print(json)
                        } catch {
                            print("Couldn't parse JSON")
                        }
                    }
                }
            }
            workerTask.resume()
        }
    }
    
    func mine(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton, workers: [WorkerModel]) {
        
    }
    
    func payouts(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton) {
        
    }
    
    func history(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton) {
        
    }
    
    
}
