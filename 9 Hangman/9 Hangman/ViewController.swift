//
//  ViewController.swift
//  9 Hangman
//
//  Created by Martin Demiddel on 13.04.19.
//  Copyright © 2019 Martin Bing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var scoreLabel: UILabel!
    var levelLabel: UILabel!
    var guessLabel: UILabel!
    var guessText: UITextField!
    var wordsList = [String]()
    
    var maximumAttempts = 7
    var attempts = 0 {
        didSet {
            if attempts >= maximumAttempts {
                tooManyAttempts()
            }
        }
    }
    
    var guessWord = "" {
        didSet {
            guessLabel.text = createPlaceholder(wordCount: guessWord.count)
        }
    }
    
    // Max length of 1 to the TextField we use, works because of delegate usage (on controller and specific field)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.text!.count < 1 || string == ""
    }
    
    func createPlaceholder(wordCount: Int) -> String {
        var placeholder = ""
        for i in 0..<wordCount {
            placeholder += i == wordCount - 1 ? "_" : "_"
        }
        
        return placeholder
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1 {
        didSet {
            levelLabel.text = "Level: \(level)"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = newLabel(text: "Score: 0")
        view.addSubview(scoreLabel)
        
        levelLabel = newLabel(text: "Level: 1")
        view.addSubview(levelLabel)
        
        guessLabel = newLabel(text: "_ _ _ _", fontSize: 48)
//        guessLabel.addObserver(self, forKeyPath: "text", options: [], context: nil)
        view.addSubview(guessLabel)
        
        guessText = UITextField()
        guessText.delegate = self
        guessText.translatesAutoresizingMaskIntoConstraints = false
        guessText.placeholder = "Type your letter in here"
        guessText.textAlignment = .center
        guessText.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        view.addSubview(guessText)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            levelLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            guessLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            guessLabel.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            
            guessText.topAnchor.constraint(equalTo: guessLabel.bottomAnchor),
            guessText.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            guessText.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),

        ])
        
        loadWords()
    }
    
    func loadWords() {
        DispatchQueue.global().async { [weak self] in
            guard let url = Bundle.main.url(forResource: "words", withExtension: "txt") else { return }
            guard let contents = try? String(contentsOf: url) else { return }
            self?.wordsList = contents.components(separatedBy: "\n").filter{ !$0.isEmpty } // last filter, makes sure no empty values are added to the Array
            DispatchQueue.main.async {
                self?.loadNewGame()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        // check guessText value for contains in guesWord
        guard let checkChar = guessText.text?.uppercased() else { return }
        if guessWord.contains(checkChar) {
            // replace range char with letter
            let rangeOfChar = guessWord.range(of: checkChar) // TODO: only finds first instance, so words like HELLO don't work
            //            more info: https://stackoverflow.com/questions/40413218/swift-find-all-occurrences-of-a-substring
            guessLabel.text = guessLabel.text?.replacingCharacters(in: rangeOfChar!, with: String(checkChar))
            score += 1
        }
        attempts += 1
        print(guessWord)
        if guessLabel.text == guessWord {
            guessedWord()
        }
        // some feedback like well done or fail would be useful before removing the char again
        textField.text = ""
    }

    func guessedWord() {
        let ac = UIAlertController(title: "Congrats!!", message: "You guessed the right word!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.level += 1
            self.loadNextGame()
        })
        present(ac, animated: true)
    }
    
    func tooManyAttempts() {
        let ac = UIAlertController(title: "Game Over", message: "The maximum # attemps is \(maximumAttempts).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Quit", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Try Again", style: .default) { _ in
            // reset game and start again
            self.loadNewGame()
        })
        present(ac, animated: true)
    }
    
    func loadNewGame() {
        level = 1
        score = 0
        loadNextGame()
    }
    func loadNextGame() {
        attempts = 0
        guessWord = wordsList.randomElement()!
    }
}

extension ViewController {
    func newLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        
        return label
    }
    
    func newLabel(text: String, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = text
        
        return label
    }
}
