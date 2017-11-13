//
//  MCurrencyVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/1/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MCurrencyVC: TabBarChildVC {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var qrView: UIImageView!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var pDateLabel: UILabel!
    @IBOutlet weak var nDateLabel: UILabel!
    @IBOutlet weak var purpleView: UIImageView!
    @IBOutlet weak var blackView: UIImageView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var inMineLabel: UILabel!
    
    let baseDiv = 1000000000000000000.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let setup = getSetup()
        let mine = getMine()
        let payouts = getPayouts()
        let coins = CryptoModel.getCoins()
        let coin = coins[setup.currencyIndex]
        currencyLabel.text = coin.getFullName()
     
        
        qrView.image = Utility.generateQRCode(from: setup.address)
        
        var total: Double = 0
        for p in payouts {
            total += Double(p.amount) / baseDiv
        }
        
        paidLabel.text = String(format: "%.4f", total)
        
        nDateLabel.text = payouts.first?.date.description
        let unpaid = mine.unpaid! / baseDiv
        inMineLabel.text = String(format: "%.4f", unpaid)
        
        let percent = unpaid * 100
        percentLabel.text = String(format: "%.1f", percent) + "% to 1.0 " + coin.suffix
        purpleView.frame.size = CGSize(width: blackView.bounds.width * CGFloat(unpaid), height: purpleView.bounds.height)
        purpleView.frame.origin = CGPoint(x: blackView.frame.origin.x, y: blackView.frame.origin.y)
        
        let time = TimeInterval((1 / (mine.perMin! / 60)) * (1-unpaid))
        pDateLabel.text = "\(Date(timeIntervalSinceNow: time))"
    }
}
