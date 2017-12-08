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
    
    
    
    
    func payouts(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton) {
        let baseUrl = "https://api.ethermine.org/miner/"
        let payoutsUrlString = URL(string: baseUrl + setup.address + "/payouts")
        if let payoutsUrl = payoutsUrlString {
            let payoutsTask = URLSession.shared.dataTask(with: payoutsUrl) {
                (data, response, error) in
                if (error != nil) {
                    print(error)
                } else {
                    if let usableData = data {
                        do {
                            var payouts = [PayoutModel]()
                            let json = try JSONSerialization.jsonObject(with: usableData, options: []) as? [String : Any]
                            //print("json! \(json!["data"])")
                            let array = try json!["data"] as? [[String : Any]]
                            
                            for el in array! {
                                let time = el["paidOn"] as! Int
                                let amount = el["amount"] as? UInt64
                                let date = Date(timeIntervalSince1970: TimeInterval(time))
                                payouts.append(PayoutModel(date: date, amount: amount!))
                                
                                
                            }
                            
                            
                            let mTabBarC = tabBarVC as! MTabBarVC
                            mTabBarC.payouts = payouts
                            //self.settings(setup: setup, tabBarVC: tabBarVC, button: button)
                            DispatchQueue.main.async {
                                
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
            payoutsTask.resume()
        }
    }
    
    
    
    
    func history(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton) {
        let baseUrl = "https://api.ethermine.org/miner/"
        let historyUrlString = URL(string: baseUrl + setup.address + "/history")
        if let historyUrl = historyUrlString {
            let historyTask = URLSession.shared.dataTask(with: historyUrl) {
                (data, response, error) in
                if (error != nil) {
                    print(error)
                } else {
                    if let usableData = data {
                        do {
                            var histories = [HistoryModel]()
                            let json = try JSONSerialization.jsonObject(with: usableData, options: []) as? [String : Any]
                            //print("json! \(json!["data"])")
                            let array = try json!["data"] as? [[String : Any]]
                            
                            for el in array! {
                                let time = el["time"] as! Int
                                if let reported = el["reportedHashrate"] as? Double {
                                    let average = el["averageHashrate"] as! Double
                                    let current = el["currentHashrate"] as! Double
                                    print("curret: :: :\(el["reportedHashrate"])")
                                    let date = Date(timeIntervalSince1970: TimeInterval(time))
                                    let hist = HistoryModel(date: date, reported: reported, average: average, current: current)
                                    histories.append(hist)
                                }
                                
                            }
                    
                            
                            let mTabBarC = tabBarVC as! MTabBarVC
                            mTabBarC.histories = histories
                            print("hists#: \(histories.count)")
                            //self.settings(setup: setup, tabBarVC: tabBarVC, button: button)
                            /*DispatchQueue.main.async {
                             
                             mTabBarC.unlockTabs()
                             mTabBarC.setTab(index: 1)
                             button.setTitle("DONE", for: .normal)
                             }*/
                            self.payouts(setup: setup, tabBarVC: tabBarVC, button: button)
                            
                        } catch {
                            print("Couldn't parse mine JSON")
                        }
                    }
                }
            }
            historyTask.resume()
        }
    }
    
    func mine(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton, workers: [WorkerModel]) {
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
                            let unpaid = dict!["unpaid"] as! Double
                            let perMin = dict!["coinsPerMin"] as! Double
                            mine = MineModel(reported: reported, current: current, average: average, workers: workers)
                            mine?.unpaid = unpaid
                            mine?.perMin = perMin
                            let mTabBarC = tabBarVC as! MTabBarVC
                            mTabBarC.mine = mine
                            mTabBarC.setup = setup
                            self.history(setup: setup, tabBarVC: tabBarVC, button: button)
                            /*DispatchQueue.main.async {
                                
                                mTabBarC.unlockTabs()
                                mTabBarC.setTab(index: 1)
                                button.setTitle("DONE", for: .normal)
                            }*/
                            
                        } catch {
                            print("Couldn't parse mine JSON")
                        }
                    }
                }
            }
            mineTask.resume()
        }
    }
    
    
    func workers(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton) {
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
                                if let current = el["currentHashrate"] as? Double {
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
                                
                            }
                            self.mine(setup: setup, tabBarVC: tabBarVC, button: button, workers: workers)
                        } catch {
                            print("Couldn't parse JSON")
                        }
                    }
                }
            }
            workerTask.resume()
        }
    }
    
   
    
    
    
}
