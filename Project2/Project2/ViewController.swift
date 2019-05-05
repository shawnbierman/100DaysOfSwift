//
//  ViewController.swift
//  Project2
//
//  Created by Shawn Bierman on 2/19/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    let maxQuestions = 6

    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany",
                      "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia",
                      "spain", "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize,
                                                            target: self,
                                                            action: #selector(showScore))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                           target: self,
                                                           action: #selector(scheduleLocal))
        askQuestion(action: nil)

    }

    func askQuestion(action: UIAlertAction!) {

        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = countries[correctAnswer].uppercased() + "  ---  SCORE: \(score)"

    }

    @IBAction func buttonTapped(_ sender: UIButton) {

        var title: String

        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong. You clicked \(countries[sender.tag].uppercased())"
            score -= 1
        }

        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 5,
                       options: [],
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { (_) in
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 5,
                           options: [],
                           animations: {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        })

        alert(title: title)
        questionsAnswered += 1

    }

    @objc fileprivate func resetGame(action: UIAlertAction!) {
        print("reset game")
        score = 0
        questionsAnswered = score
        askQuestion(action: nil)
    }

    func alert(title: String) {

        print("Score: \(score)")

        if questionsAnswered < (maxQuestions - 1) {
            let alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alert, animated: true)
        } else {

            let defaults = UserDefaults.standard
            let highScore = defaults.integer(forKey: "highScore")
            print("High score is \(highScore)")
            if score > highScore {
                defaults.set(score, forKey: "highScore")
                let alert = UIAlertController(title: "High Score",
                                           message: "Congratulations! \(score) is your new high score.",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: resetGame))
                present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Game Over",
                                              message: "Your final score is \(score)",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: resetGame))
                present(alert, animated: true, completion: nil)
            }
        }
    }

    @objc func showScore() {

        let alert = UIAlertController(title: "Your score is \(score)!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true)
    }

    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        let action = UNNotificationAction(identifier: "show", title: "Remind me to play.", options: .foreground)
        let alarm  = UNNotificationCategory(identifier: "alarm", actions: [action], intentIdentifiers: [], options: [])

        center.delegate = self
        center.setNotificationCategories([alarm])
    }

    @objc func scheduleLocal() {

        let alert = UIAlertController(title: "Play Daily?",
                                      message: "Would you like to be reminded to play daily?",
                                      preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] (_) in

            self?.registerCategories()

            let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()

            let content = UNMutableNotificationContent()
                content.title               = "Time to play!"
                content.body                = "You asked to remind to play the game. Let's go!"
                content.categoryIdentifier  = "alarm"
                content.userInfo            = ["customData": "fizzbuzz"]
                content.sound               = .default

            var dateComponents = DateComponents()
                dateComponents.hour = 8

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            center.add(request)
        }))
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()

        showAlert(title: "Time to play!",
                  message: "You wanted a daily reminder.",
                  btnTitle: "OK")

        completionHandler()
    }

    fileprivate func showAlert(title withTitle: String, message withMsg: String, btnTitle: String) {
        let alert = UIAlertController(title: withTitle, message: withMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))

        present(alert, animated: true)
    }
}

// 1. Try adding the image name to the list of items that are shared.
//     The activityItems parameter is an array, so you can add strings and other things freely.
//      Note: Facebook won’t let you share text, but most other share options will.
// 2. Go back to project 1 and add a bar button item to the main view controller that recommends
//    the app to other people.
// 3. Go back to project 2 and add a bar button item that shows their score when tapped.
