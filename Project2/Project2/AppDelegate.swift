//
//  AppDelegate.swift
//  Project2
//
//  Created by Shawn Bierman on 2/19/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        registerLocal()

        return true
    }

    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            print("reseting: \(key)")
            defaults.removeObject(forKey: key)
        }
    }

    fileprivate func registerLocal() {
        let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted { print("Yay!") } else { print("Doh!")}
        }
    }
}
