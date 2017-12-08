//
//  NanopoolEthApi.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/13/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
struct NanopoolEthAPI : MineProtocol {
    
    func workers(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton) {
        let baseUrl = "https://api.nanopool.org/v1/eth/workers/"
        let workerUrlString = URL(string: baseUrl + setup.address)
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
                            let array = try json!["data"] as? [[String : Any]]
                            
                            
                            for (key, el) in array!.enumerated() {
                                if let id = el["id"] as? String {
                                    print(id)
                                    let baseWorkerAvgUrl = "https://api.nanopool.org/v1/eth/avghashratelimited/"
                                    let workerAvgUrlString = URL(string: baseWorkerAvgUrl + setup.address + "/" + id + "/24")
                                    if let workerAvgUrl = workerAvgUrlString {
                                        let workerAvgTask = URLSession.shared.dataTask(with: workerAvgUrl) {
                                            (data, reposponse, error) in
                                            if (error != nil) {
                                                print(error)
                                            } else {
                                                if let usableData = data {
                                                    do {
                                                        let json = try JSONSerialization.jsonObject(with: usableData, options: []) as? [String : Any]
                                                        //print(json)
                                                        let dict = try json!["data"]
                                                        
                                                        
                                                        if let avgHR = dict! as? Double {
                                                            print("\(avgHR)")
                                                            let baseWorkers = 1
                                                        }
                                                        
                                                    } catch {
                                                        print("Couldn't parse JSON workers avg")
                                                    }
                                                }
                                            }
                                        }
                                        workerAvgTask.resume()
                                    }
                                    if key == array!.count - 1 {
                                        print("last element")
                                    }
                                }
                                
                            }
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
