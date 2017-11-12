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
    
    func apiCall(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton)
    
    func apiSubCall(setup: SetupModel, tabBarVC: UITabBarController, button: UIButton, workers: [WorkerModel])
    
}
