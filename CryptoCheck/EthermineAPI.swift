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
    
    func apiSubCall(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton, workers: [WorkerModel]) {
        let baseUrl = "https://api.ethermine.org/miner/"
        let mineUrlString = URL(string: baseUrl + setup.address + "/currentStats")
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
                                mTabBarC.setup = setup
                                mTabBarC.unlockTabs()
                                mTabBarC.setTab(index: 1)
                                button.setTitle("DONE", for: .normal)
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
    
    
    func apiCall(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton) {
        let baseUrl = "https://api.ethermine.org/miner/"
        let workerUrlString = URL(string: baseUrl + setup.address + "/workers")
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
                                let lastSeen = el["lastSeen"] as! Int
                                let lastSeenDate = Date(timeIntervalSince1970: TimeInterval(lastSeen))
                                print("\(lastSeenDate) vs \(Date())")
                                
                                let worker = WorkerModel(name: name, reported: reported, current: current, average: average, validShares: valid, invalidShares: invalid, staleShares: stale)
                                worker.lastSeen = lastSeenDate
                                
                                workers.append(worker)
                                print(worker)
                                
                            }
                            self.apiSubCall(setup: setup, tabBarVC: tabBarVC, button: button, workers: workers)
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
