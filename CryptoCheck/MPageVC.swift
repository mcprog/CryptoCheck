//
//  MPageVC.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 11/1/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//

import Foundation
import UIKit
class MPageVC: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
    }
    
}

// extension allows for implementing methods that don't care about any internals stuff of the class
extension MPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
