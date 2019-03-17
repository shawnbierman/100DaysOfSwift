//
//  ViewController.swift
//  milestone3
//
//  Created by Shawn Bierman on 3/16/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let allowedGuesses = 7
    let alphabet = ["A","B","C","D","E","F","G",
                    "H","I","J","K","L","M","N",
                    "O","P","Q","R","S","T","U",
                    "-","V","W","X","Y","Z","-"]

    let wordLabel = UILabel()

    var letterButtons = [UIButton]()
    var activeButtons = [UIButton]()
    var hiddenButtons = [UIButton]()
    
    var words = [String]()
    var usedWords = [String]()
    var usedLetters = [String]()
    var guessCount = 0
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        let buttonsView = UIView()
        buttonsView.backgroundColor = .lightGray
        
        wordLabel.textAlignment = .center
        wordLabel.backgroundColor = .green
        wordLabel.baselineAdjustment = .alignCenters
        wordLabel.text = "TEMPERATURE"
        wordLabel.font = UIFont.systemFont(ofSize: 50)
        
        for view in [buttonsView, wordLabel] {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        let width = 54
        let height = width
        
        for row in 0..<4 {
            for column in 0..<7 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                letterButton.setTitle(alphabet[letterButtons.count], for: .normal)
                letterButton.addTarget(self, action: #selector(handleLetterTapped), for: .touchUpInside)
                letterButton.layer.cornerRadius = 26
                letterButton.backgroundColor = .darkGray
                letterButton.tintColor = .white
                letterButton.layer.borderColor = UIColor.white.cgColor
                letterButton.layer.borderWidth = 4

                if (letterButton.titleLabel?.text?.contains("-"))! {
                    letterButton.isHidden = true
                }
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
        let constraints: [NSLayoutConstraint] = [
            buttonsView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 250),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            
            wordLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            wordLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            wordLabel.bottomAnchor.constraint(equalTo: buttonsView.topAnchor, constant: -40),
            wordLabel.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func handleLetterTapped(_ sender: UIButton) {
        guard let key = sender.titleLabel?.text else { return }
        guard let word = wordLabel.text else { return }
        
        sender.isHidden = true
        self.guessCount += 1

        if word.contains(key) {
            print("Found \(key) in \(word)")
        }
        
        hiddenButtons.append(sender)

        if guessCount == allowedGuesses {
            let ac = UIAlertController(title: "Game Over", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New Word", style: .default, handler: { [weak self] _ in
                self?.resetGame()
            }))
            print("Game over")
        }
    }
    
    func loadWordList() {
        if let textfileUrl = Bundle.main.url(forResource: "Wordlist", withExtension: "txt") {
            if let stringsFromTextfile = try? String(contentsOf: textfileUrl) {
                self.words = stringsFromTextfile.components(separatedBy: "\n").shuffled()
                print(words)
            }
        }
    }
    
    func resetGame() {
        guessCount = 0
        for button in hiddenButtons { button.isHidden = false }
        hiddenButtons.removeAll(keepingCapacity: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWordList()
    }
}
