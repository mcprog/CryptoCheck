//
//  MineProtocol.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/9/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
protocol MineProtocol {
    
    func workers(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton)
    
    func mine(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton, workers: [WorkerModel])
    
    
    func payouts(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton)
    
    func history(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton)
    
    
}
