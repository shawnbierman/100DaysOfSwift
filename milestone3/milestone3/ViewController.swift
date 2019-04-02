//
//  ViewController.swift
//  milestone3
//
//  Created by Shawn Bierman on 3/16/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let alphabet = ["A","B","C","D","E","F","G",
                    "H","I","J","K","L","M","N",
                    "O","P","Q","R","S","T","U",
                    "-","V","W","X","Y","Z","-"]

    var letterButtons           = [UIButton]()      // all the buttons with letters on them
    var hiddenButtons           = [UIButton]()      // buttons that have been used
    var gameWordLabel           = UILabel()         // the label that displays currentWord
    var guessesLabel            = UILabel()         // the label that displays remainingGuesses
    
    var availableWords          = [String]()        // all the words to choose from
    var usedWords               = [String]()        // words that have been used
    
    var gameWord                = ""                // the current word we're guessing
    var usedLetters             = [String]()        // letters that have been used (guessed)
    
    let allowedGuesses          = 7
    var remainingGuesses        = 7 {
        didSet {
            guessesLabel.text = "GUESSES REMAINING: \(remainingGuesses)"
        }
    }
    var gameWordMasked: String = "" {
        didSet {
            self.gameWordLabel.text = gameWordMasked
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGame()
    }
    
    fileprivate func startGame() {
        
        // reset guess counter
        remainingGuesses = allowedGuesses
        
        usedWords.removeAll()
        usedLetters.removeAll()
        hiddenButtons.removeAll()
        
        if availableWords.isEmpty {
            loadWordsFromDisk()
        }
        
        loadNewGameWord()
        
    }
    
    @objc func handleTap(_ sender: UIButton) {
        
        guard let key = sender.titleLabel?.text else { return } // get letter of button
        
        if gameWord.contains(key) {                             // is this letter in the gameWord?
            
            print("Found \(key) in \(gameWord)")
            // do word thing here
            
        } else {
            
            remainingGuesses -= 1
        }
        
        if remainingGuesses == 0 {
            
            let ac = UIAlertController(title: "Game Over!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: { [weak self] _ in
                
                self?.resetAllButtons()
                self?.startGame()
                
            }))
            
            present(ac, animated: true)
            print("Game over")
            
        }
        
        sender.isHidden = true          // now hide button, it's been used.
        hiddenButtons.append(sender)
    }
    
    fileprivate func loadNewGameWord() {
        
        if let word = getRandomWord(from: &availableWords) {
            
            gameWord = word
            gameWordLabel.text = gameWord
            
            for char in gameWord {
                
                let c = String(char)
                
                if usedLetters.contains(c) {
                    gameWordMasked += c
                } else {
                    gameWordMasked += "-"
                }
            }
            
            gameWordLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.22),
                           initialSpringVelocity: CGFloat(9.0),
                           options: UIView.AnimationOptions.allowUserInteraction,
                           animations: {
                            
                            self.gameWordLabel.transform = CGAffineTransform.identity
                            
            }, completion: nil)
        } else {
            print("Game over.")
        }
    }
    
    fileprivate func getRandomWord(from words: inout [String]) -> String? {
        
        // pull random word from array and remove it from same array
        if let word = words.randomElement(),
            let index = words.firstIndex(of: word) {
            
            words.remove(at: index)
            return word
            
        } else {
            return nil
        }
    }
    
    fileprivate func loadWordsFromDisk() {
        
        // load all words from file and randomize
        if availableWords.isEmpty {
            if let textfileUrl = Bundle.main.url(forResource: "Wordlist", withExtension: "txt") {
                if let stringsFromTextfile = try? String(contentsOf: textfileUrl) {
                    
                    self.availableWords = stringsFromTextfile.components(separatedBy: "\n").shuffled().filter { $0 != "" }
                    print("Words found: \(self.availableWords.count)")
                    print(self.availableWords)
                }
            }
        } else {
            // out of words, reload.
        }
    }
    
    fileprivate func resetAllButtons() {
        
        for button in hiddenButtons {
            
            button.isHidden = false
            button.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            
            UIView.animate(withDuration: 1.0,
                           delay: Double.random(in: 0...0.09),
                           usingSpringWithDamping: CGFloat(0.12),
                           initialSpringVelocity: CGFloat(9.0),
                           options: UIView.AnimationOptions.allowUserInteraction,
                           animations: {
                            
                            button.transform = CGAffineTransform.identity
                            
            }, completion: nil)
        }
    }
}

extension ViewController {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        let buttonsView = UIView()
        
        gameWordLabel.textAlignment = .center
        gameWordLabel.baselineAdjustment = .alignCenters
        gameWordLabel.text = gameWord
        gameWordLabel.textColor = .darkGray
        gameWordLabel.font = UIFont.systemFont(ofSize: 50, weight: .black)
        gameWordLabel.adjustsFontSizeToFitWidth = true
        
        guessesLabel.textAlignment = .center
        guessesLabel.text = "GUESSES REMAINING: \(remainingGuesses)"
        guessesLabel.textColor = .darkGray
        guessesLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        guessesLabel.adjustsFontSizeToFitWidth = true
        
        for view in [buttonsView, gameWordLabel, guessesLabel] {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        let width = 54
        let height = width
        
        for row in 0..<4 {
            for column in 0..<7 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
                letterButton.setTitle(alphabet[letterButtons.count], for: .normal)
                letterButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
                letterButton.layer.cornerRadius = 27
                letterButton.backgroundColor = .darkGray
                letterButton.tintColor = .white
                letterButton.clipsToBounds = true
                letterButton.layer.borderColor = UIColor.white.cgColor
                letterButton.layer.borderWidth = 4
                letterButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
                
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
            
            gameWordLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            gameWordLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            gameWordLabel.bottomAnchor.constraint(equalTo: buttonsView.topAnchor, constant: -40),
            gameWordLabel.heightAnchor.constraint(equalToConstant: 150),
            
            guessesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            guessesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            guessesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            guessesLabel.heightAnchor.constraint(equalToConstant: 24)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
