//
//  MWorkerCell.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/12/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit

class WorkerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastSeenLabel: UILabel!
    @IBOutlet weak var rHashLabel: UILabel!
    @IBOutlet weak var cHashLabel: UILabel!
    @IBOutlet weak var aHashLabel: UILabel!
    @IBOutlet weak var validLabel: UILabel!
    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var staleLabel: UILabel!
    
    
}
