//
//  AppDelegate.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 23/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //RootVC
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navController
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        return true
    }
}
