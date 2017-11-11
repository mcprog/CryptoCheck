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
    
    func apiCall(address: String, tabBarVC: UITabBarController)
    
    func apiSubCall(address: String, tabBarVC: UITabBarController, workers: [WorkerModel])
    
}
