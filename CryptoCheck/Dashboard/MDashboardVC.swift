//
//  MDashboardVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/1/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MDashboardVC: UIViewController {
    
    @IBOutlet weak var amtLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var rHashLabel: UILabel!
    @IBOutlet weak var cHashLabel: UILabel!
    @IBOutlet weak var aHashLabel: UILabel!
    
    var cnt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    func update() {
        setClock()
        setHashrate()
    }
    
    private func setHashrate() {
        let mine = getMine()
        let rMH = String(format: "%.1f", Utility.toMH(hash: mine.reported!))
        let aMH = String(format: "%.1f", Utility.toMH(hash: mine.average!))
        let cMH = String(format: "%.1f", Utility.toMH(hash: mine.current!))
        rHashLabel.text = "\(rMH) MH/s"
        aHashLabel.text = "\(aMH) MH/s"
        cHashLabel.text = "\(cMH) MH/s"
    }
    
    private func setClock() {
        cnt += 1
        print("settung clock \(cnt)")
        let now = Date()
        var mostRecent: Date?
        for w in getMine().workers! {
            if let date = w.lastSeen {
                if (mostRecent == nil) {
                    mostRecent = date
                }
                else if (mostRecent! < date) {
                    mostRecent = date
                }
            }
        }
        let seconds = now.timeIntervalSince(mostRecent!)
        if (seconds < 60) {
            amtLabel.text = "\(Int(seconds))"
            unitsLabel.text = "secs ago"
        }
        else if (seconds < 3600) {
            amtLabel.text = "\(Int(seconds / 60))"
            unitsLabel.text = "mins ago"
        }
        else if (seconds < 86400) {
            amtLabel.text = "\(Int(seconds / 3600))"
            unitsLabel.text = "hrs ago"
        } else {
            amtLabel.text = "\(Int(seconds / 86400))"
            unitsLabel.text = "days ago"
        }
        
    }
    
    func getMine() -> MineModel {
        return (tabBarController as! MTabBarVC).mine!
    }
    
    @IBAction func unwindFromWorkers(segue: UIStoryboardSegue) {
        
    }
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "dashboardWorkersEmbed") {
            let mDashboardWorkersVC = segue.destination as? MDashboardWorkersVC
            mine = (tabBarController as! MTabBarVC).mine
            mDashboardWorkersVC?.count = mine?.workers?.count
            print("embed called")
        }
    }*/
    
}
