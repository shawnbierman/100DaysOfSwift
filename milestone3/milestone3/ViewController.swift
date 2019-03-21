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

    var letterButtons = [UIButton]()    // all the buttons with letters on them
    var hiddenButtons = [UIButton]()    // buttons that have been used
    var wordLabel = UILabel()           // the label that displays currentWord
    
    var currentWord: String = ""        // the current word
    var currentWordMask: String = ""    // the currentWord masked by underscores
    var words = [String]()              // all the words to choose from
    var usedWords = [String]()          // words that have been used
    var usedLetters = [String]()        // letters that have been used (guessed)
    var guessCount = 0                  // current total of guesses
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        let buttonsView = UIView()
        
        wordLabel.textAlignment = .center
        wordLabel.baselineAdjustment = .alignCenters
        wordLabel.text = currentWord
        wordLabel.textColor = .black
        wordLabel.font = UIFont.systemFont(ofSize: 50, weight: .black)
        
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
            buttonsView.heightAnchor.constraint(equalToConstant: 230),
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
            let ac = UIAlertController(title: "Game Over!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: { [weak self] _ in
                self?.startGame()
            }))
            present(ac, animated: true)
            print("Game over")
        }
    }
    
    func loadWordList() {
        if words.count == 0 {
            if let textfileUrl = Bundle.main.url(forResource: "Wordlist", withExtension: "txt") {
                if let stringsFromTextfile = try? String(contentsOf: textfileUrl) {
                    self.words = stringsFromTextfile.components(separatedBy: "\n").shuffled()
//                    print(words)
                }
            }
        }
    }

    func getRandomWord() {
        if let word = words.randomElement() {
            currentWord = word
            words.remove(at: words.firstIndex(of: currentWord)!)
            print(words)
            for char in currentWord {
                print("char: \(char)")
            }
        } else {
            // No more words. Game over.
        }
    }

    func startGame() {
        guessCount = 0
        
        for button in hiddenButtons {
            button.isHidden = false

            button.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            UIView.animate(withDuration: 1.0, delay: Double.random(in: 0...0.09), usingSpringWithDamping: CGFloat(0.12), initialSpringVelocity: CGFloat(9.0), options: UIView.AnimationOptions.allowUserInteraction, animations: { button.transform = CGAffineTransform.identity }, completion: nil)
        }
        
        words.removeAll(keepingCapacity: true)
        usedWords.removeAll(keepingCapacity: true)
        usedLetters.removeAll(keepingCapacity: true)
        hiddenButtons.removeAll(keepingCapacity: true)
        
        loadWordList()
        getRandomWord()
//        currentWord = getRandomWord()
        
        wordLabel.text = currentWord
        wordLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: CGFloat(0.22), initialSpringVelocity: CGFloat(9.0), options: UIView.AnimationOptions.allowUserInteraction, animations: { self.wordLabel.transform = CGAffineTransform.identity }, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
}

//extension Array {
//    mutating func pluck(_ element: String) -> String? {
//        if let word = self.randomElement() {
//            self.removeAll { $0 == word }
//        }
//    }
//}
