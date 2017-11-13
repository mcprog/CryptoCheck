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
        currencyLabel.text = CryptoModel.getCoins()[getSetup().currencyIndex].getFullName()
        print(getMinPayout())
        
        qrView.image = generateQRCode(from: getSetup().address)
        
        var total: Double = 0
        for p in getPayouts() {
            total += Double(p.amount) / baseDiv
        }
        
        paidLabel.text = String(format: "%.4f", total)
        
        nDateLabel.text = getPayouts().first?.date.description
        let unpaid = getMine().unpaid! / baseDiv
        inMineLabel.text = String(format: "%.4f", unpaid)
        
        let percent = unpaid * 100
        percentLabel.text = String(format: "%.1f", percent) + "% to 1.0 " + CryptoModel.getCoins()[getSetup().currencyIndex].suffix
        purpleView.frame.size = CGSize(width: blackView.bounds.width * CGFloat(unpaid), height: purpleView.bounds.height)
        purpleView.frame.origin = CGPoint(x: blackView.frame.origin.x, y: blackView.frame.origin.y)
        //purpleView.layoutIfNeeded()
        
        
        let time = TimeInterval((1 / (getMine().perMin! / 60)) * (1-unpaid))
        pDateLabel.text = "\(Date(timeIntervalSinceNow: time))"
    }
    
    func keepPrecision(uint: UInt64) -> String {
        let string = String(uint)
        let prefix = string.prefix(1)
        let index = string.index(string.startIndex, offsetBy: 1)
        let suffix = string.suffix(from: index)
        return prefix + "." + suffix
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
            
        }
        return nil
    }
    
    func getMine() -> MineModel {
        return (tabBarController as! MTabBarVC).mine!
    }
    
    func getSetup() -> SetupModel {
        return (tabBarController as! MTabBarVC).setup!
    }
    
    func getMinPayout() -> Double {
        return -1
    }
    
    func getPayouts() -> [PayoutModel] {
        return (tabBarController as! MTabBarVC).payouts!
    }
    
}
