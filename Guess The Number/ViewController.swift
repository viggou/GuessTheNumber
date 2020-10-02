//
//  ViewController.swift
//  Guess The Number
//
//  Created by Viggo Lekdorf on 01/10/2020.
//

import Cocoa

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

class ViewController: NSViewController, NSWindowDelegate {
    
    @IBAction func guessMenuBar(_ sender: NSMenuItem) {
        self.tryGuess()
    }
    
    @IBAction func resetMenuBar(_ sender: NSMenuItem) {
        self.resetGame()
    }

    var numberToBeGuessed = 0
    var guessedCorrect = false
    var tries = 0
    
    @IBOutlet weak var guessInput: NSTextField!
    
    @IBOutlet weak var guideLabel: NSTextField!
    
    @IBOutlet weak var triesLabel: NSTextField!
    
    @IBOutlet weak var feedbackLabel: NSTextField!
    
    @IBAction func guessButton(_ sender: Any) {
        self.tryGuess()
    }
    
    @IBAction func resetButton(_ sender: Any) {
        self.resetGame()
    }
    
    func tryGuess() {
        let guess = guessInput.stringValue
        if (guessedCorrect) {
            return
        }
        if (!guess.isInt) {
            feedbackLabel.stringValue = "You have to enter a number!"
            return
        }
        let guessInt = guessInput.intValue
        if (guessInt == numberToBeGuessed) {
            feedbackLabel.stringValue = "Correct! The random number was \(numberToBeGuessed)."
            guessedCorrect = true
        }
        else if (guessInt > numberToBeGuessed) {
            feedbackLabel.stringValue = "Too high. The number is lower than \(guessInt)."
        }
        else if (guessInt < numberToBeGuessed) {
            feedbackLabel.stringValue = "Too low. The number is higher than \(guessInt)."
        }
        else {
            feedbackLabel.stringValue = "Error"
            return
        }
        self.updateTries()
    }
    
    func genRandomNumber(firstNum: Int, secondNum: Int) {
        numberToBeGuessed = Int.random(in: firstNum...secondNum)
        guideLabel.stringValue = "A random number between \(firstNum) and \(secondNum) has been generated. Can you guess it?"
        feedbackLabel.stringValue = "To guess, type a number in the text field and press the \"Guess\" button."
        triesLabel.stringValue = "Times guessed: 0"
        tries = 0
        // print("The number is \(numberToBeGuessed).")
    }
    
    func updateTries() {
        tries += 1
        triesLabel.stringValue = "Times guessed: \(tries)"
    }
    
    func resetGame() {
        guessedCorrect = false
        self.genRandomNumber(firstNum: 0, secondNum: 10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.genRandomNumber(firstNum: 0, secondNum: 10)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            
        }
    }
    
    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
    
}

