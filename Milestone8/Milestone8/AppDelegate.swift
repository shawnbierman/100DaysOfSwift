//
//  AppDelegate.swift
//  Milestone8
//
//  Created by Shawn Bierman on 5/5/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: FoldersViewController())

        return true
    }
}
