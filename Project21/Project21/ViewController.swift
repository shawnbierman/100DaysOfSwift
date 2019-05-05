//
//  ViewController.swift
//  Project21
//
//  Created by Shawn Bierman on 4/28/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UserNotifications
import UIKit

// swiftlint:disable line_length
class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarButtons()
    }

    fileprivate func setupNavBarButtons() {
        let regBtn   = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        let schedBtn = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))

        navigationItem.leftBarButtonItem  = regBtn
        navigationItem.rightBarButtonItem = schedBtn
    }

    func registerCategories() {
        let center        = UNUserNotificationCenter.current()
        let alarmCategory = UNNotificationCategory(identifier: "alarm",
                                                   actions: [UNNotificationAction(identifier: "show", title: "Tell me more", options: .foreground),
                                                             UNNotificationAction(identifier: "delay", title: "Remind me tomorrow", options: .foreground)],
                                                   intentIdentifiers: [],
                                                   options: [])

        center.delegate = self
        center.setNotificationCategories([alarmCategory])
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted { print("Yay!") } else { print("Doh!") }
        }
    }

    @objc func scheduleLocal(delay delayed: Bool = true) {

        registerCategories()

        let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
            content.title               = "Late wake up call"
            content.body                = "The early bird catches the worm, but the second mouse gets the cheese."
            content.categoryIdentifier  = "alarm"
            content.userInfo            = ["customData": "fizzbuzz"]
            content.sound               = .default

        if delayed {
            var dateComponents = DateComponents()
                dateComponents.hour   = 8
                dateComponents.minute = 0
                dateComponents.second = 0

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            center.add(request)
        } else {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            center.add(request)
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo
        let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()

        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                showAlert(title: "Opened", message: "You clicked on the notification.", btnTitle: "OK")
            case "show":
                showAlert(title: "More Information", message: "So you want to see even more information?", btnTitle: "OK")
            case "delay":
                scheduleLocal(delay: true)
            default:
                break
            }
        }
        completionHandler()
    }

    fileprivate func showAlert(title withTitle: String, message withMsg: String, btnTitle: String) {
        let alert = UIAlertController(title: withTitle, message: withMsg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))

        present(alert, animated: true)
    }
}
