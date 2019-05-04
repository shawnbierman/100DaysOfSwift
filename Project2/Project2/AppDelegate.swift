//
//  AppDelegate.swift
//  Project2
//
//  Created by Shawn Bierman on 2/19/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        func resetDefaults() {
            let defaults = UserDefaults.standard
            let dictionary = defaults.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                print("reseting: \(key)")
                defaults.removeObject(forKey: key)
            }
        }
        //        resetDefaults()
        return true
    }
}
