//
//  MDashboardWorkersVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/11/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MDashboardWorkersVC: UITableViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    var count: Int?
    var workers: [WorkerModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let mDashboardVC = self.parent as? MDashboardVC
        countLabel.text = "\(mDashboardVC?.getMine().workers?.count ?? -1)"
        workers = mDashboardVC?.getMine().workers
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mWorkersTVC = segue.destination as? MWorkersTVC {
            mWorkersTVC.workers = workers!
        }
    }
    
}
