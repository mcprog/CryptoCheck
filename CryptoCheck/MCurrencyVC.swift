//
//  MCurrencyVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/1/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MCurrencyVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mTabBarC = tabBarController as! MTabBarVC
        print(mTabBarC.mine)
    }
    
}
