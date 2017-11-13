//
//  AppDelegate.swift
//  CryptoCheck
//
//  Created by Michael Curtis on 10/21/17.
//  Copyright © 2017 Michael Curtis. All rights reserved.
//  Right now the I have been testing with only one currency, so the only configuration that works is Ethereum, ethermine.org
//  You will need an address to test, I have been using: CAbe2896FeB48a8f1E98d23d7505da426a46eDaA
//  More addresses can be found at: https://ethermine.org/ under "Recently mined blocks
//  As  you can see, I have CrptyoCompare api, the Ethermine, the Chart library, and a QR code generator. You can scan the QR code gen and the actual address will showup!
// I am still missing the kraken api but i think that I am going to focus on the mining aspect over the trading ascpect.
// Thanks for giving some extra time to work on this (Milestone 3)
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appear = UITabBar.appearance()
        appear.tintColor = UIColor(red: 174.0/255.0, green: 113.0/255.0, blue: 230.0/255.0, alpha: 1)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

