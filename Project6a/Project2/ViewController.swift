//
//  ViewController.swift
//  Project2
//
//  Created by Shawn Bierman on 2/19/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    let maxQuestions = 10

    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showScore))
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

        alert(title: title)
        questionsAnswered += 1

    }
    
    func alert(title: String) {
        
        if questionsAnswered < maxQuestions {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Game Over", message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: askQuestion))
            present(ac, animated: true, completion: nil)
            score = 0
            questionsAnswered = 0
        }
        
    }
    
    @objc func showScore() {
        
        let ac = UIAlertController(title: "Your score is \(score)!", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
}

// 1. Try adding the image name to the list of items that are shared. The activityItems parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will.
// 2. Go back to project 1 and add a bar button item to the main view controller that recommends the app to other people.
// 3. Go back to project 2 and add a bar button item that shows their score when tapped.
