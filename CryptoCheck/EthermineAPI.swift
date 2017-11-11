//
//  EthermineAPI.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/9/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
struct EthermineAPI : MineProtocol {
    
    func apiSubCall(address: String, tabBarVC: UITabBarController, workers: [WorkerModel]) {
        let baseUrl = "https://api.ethermine.org/miner/"
        let mineUrlString = URL(string: baseUrl + address + "/currentStats")
        if let mineUrl = mineUrlString {
            let mineTask = URLSession.shared.dataTask(with: mineUrl) {
                (data, response, error) in
                if (error != nil) {
                    print(error)
                } else {
                    if let usableData = data {
                        do {
                            var mine: MineModel?
                            let json = try JSONSerialization.jsonObject(with: usableData, options: []) as? [String : Any]
                            //print("json! \(json!["data"])")
                            let dict = try json!["data"] as? [String: Any]
                            let lastSeen = dict!["lastSeen"]
                            let reported = dict!["reportedHashrate"] as! Double
                            let current = dict!["currentHashrate"] as! Double
                            let average = dict!["averageHashrate"] as! Double
                            mine = MineModel(reported: reported, current: current, average: average, workers: workers)
                            let mTabBarC = tabBarVC as! MTabBarVC
                            
                            DispatchQueue.main.async {
                                mTabBarC.mine = mine
                                mTabBarC.unlockTabs()
                                mTabBarC.setTab(index: 1)
                            }
                            
                        } catch {
                            print("Couldn't parse mine JSON")
                        }
                    }
                }
            }
            mineTask.resume()
        }
    }
    
    
   func apiCall(address: String, tabBarVC: UITabBarController) {
        let baseUrl = "https://api.ethermine.org/miner/"
        let workerUrlString = URL(string: baseUrl + address + "/workers")
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
                            
                            for el in array! {
                                let current = el["currentHashrate"] as! Double
                                let average = el["averageHashrate"] as! Double
                                let reported = el["reportedHashrate"] as! Double
                                let stale = el["staleShares"]  as! Int
                                let invalid = el["invalidShares"] as! Int
                                let valid = el["validShares"] as! Int
                                let name = el["worker"] as! String
                                let lastSeen = el["lastSeen"]
                                
                                let worker = WorkerModel(name: name, reported: reported, current: current, average: average, validShares: valid, invalidShares: invalid, staleShares: stale)
                                workers.append(worker)
                                //print(worker)
                                
                            }
                            self.apiSubCall(address: address, tabBarVC: tabBarVC, workers: workers)
                        } catch {
                            print("Couldn't parse JSON")
                        }
                    }
                }
            }
            workerTask.resume()
        }
    }
    
    /*func generateMineModel(address: String, workers: [WorkerModel]) -> MineModel? {
        let baseUrl = "https://api.ethermine.org"
        print(address)
        let mineSuffix = "/miner/" + address + "/currentStats"
        let urlString = URL(string: baseUrl + mineSuffix)
        var mine: MineModel?
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if (error != nil) {
                    print(error)
                } else {
                    if let usableData = data {
                        do {
                            
                            let json = try JSONSerialization.jsonObject(with: usableData, options: []) as? [String : Any]
                            print("json! \(json!["data"])")
                            let dict = try json!["data"] as? [String: Any]
                            print("dick")
                            print(dict!)
                            let lastSeen = dict!["lastSeen"]
                            let reported = dict!["reportedHashrate"] as! Double
                            let current = dict!["currentHashrate"] as! Double
                            let average = dict!["averageHashrate"] as! Double
                            print("in do")
                            mine = MineModel(reported: reported, current: current, average: average, workers: workers)
                            print("mine")
                            print(mine!)
                            
                        } catch {
                            print("Couldn't parse JSON")
                        }
                    }
                }
            }
            task.resume()
            return mine
        }
        return nil
    }
    
    func getWorkerModels(address: String) -> [WorkerModel] {
        let urlString = URL(string: getBaseUrl() + address + "/workers")
        var workers = [WorkerModel]()
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if (error != nil) {
                    print(error)
                } else {
                    if let usableData = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: usableData, options: []) as? [String : Any]
                            print(json!["data"])
                            let array = try json!["data"] as? [[String : Any]]
                            
                            for el in array! {
                                print(":::")
                                print(el)
                                let current = el["currentHashrate"] as! Double
                                let average = el["averageHashrate"] as! Double
                                let reported = el["reportedHashrate"] as! Double
                                let stale = el["staleShares"]  as! Int
                                let invalid = el["invalidShares"] as! Int
                                let valid = el["validShares"] as! Int
                                let name = el["worker"] as! String
                                let lastSeen = el["lastSeen"]
                                
                                let worker = WorkerModel(name: name, reported: reported, current: current, average: average, validShares: valid, invalidShares: invalid, staleShares: stale)
                                workers.append(worker)
                                print(worker)
                            }
                        } catch {
                            print("Couldn't parse JSON")
                        }
                    }
                }
            }
            task.resume()
        }
        return workers
    }
    
*/
    
    
    
}
