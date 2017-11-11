//
//  MTabBarVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/1/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MTabBarVC: UITabBarController {
    
    var mine: MineModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func unlockTabs() {
        for item in tabBar.items! {
            item.isEnabled = true
        }
    }
    
    func setTab(index: Int) {
        if (index < 0) {
            return
        }
        if (index >= tabBar.items!.count) {
            return
        }
        
        tabBarController?.selectedIndex = index
        
    }
    
}


