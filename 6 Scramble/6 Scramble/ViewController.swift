//
//  ViewController.swift
//  6 Scramble
//
//  Created by Martin Demiddel on 07.04.19.
//  Copyright © 2019 Martin Bing. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            guard let startWords = try? String(contentsOf: startWordsURL) else { return }
            allWords = startWords.components(separatedBy: "\n")
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }

    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    if lowerAnswer.count <= 3 {
                        errorTitle = "Word 3 or less chars"
                        errorMessage = "The answer needs to be larger than 3 chars"
                        showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage)
                        
                        return
                    }
                    
                    if (title?.lowercased().hasPrefix(answer))! {
                        errorTitle = "Word prefix"
                        errorMessage = "The answer can not be a prefix of the word"
                        showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage)
                        
                        return
                    }
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up, you know!"
                    showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage)
                }
            } else {
                errorTitle = "Word already used"
                errorMessage = "Be more original!"
                showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage)
            }
        } else {
            guard let title = title else { return }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title.lowercased())."
            showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage)
        }
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
}

