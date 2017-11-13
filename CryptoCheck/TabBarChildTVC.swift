//
//  TabBarChildVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/13/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class TabBarChildTVC: UITableViewController {
    
    
    func getMine() -> MineModel {
        return (tabBarController as! MTabBarVC).mine!
    }
    
    func getSetup() -> SetupModel {
        return (tabBarController as! MTabBarVC).setup!
    }
    
    func getPayouts() -> [PayoutModel] {
        return (tabBarController as! MTabBarVC).payouts!
    }
    
    func getHistories() -> [HistoryModel] {
        return (tabBarController as! MTabBarVC).histories!
    }
}

