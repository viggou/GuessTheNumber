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

extension ViewController: PrefsDelegate {
    func sendPrefValues(sendMinNum: Int, sendMaxNum: Int, sendTriesOn: Bool, sendMaxTries: Int) {
        applyPrefs(applyMinNum: sendMinNum, applyMaxNum: sendMaxNum, applyTriesOn: sendTriesOn, applyMaxTries: sendMaxTries)
    }
}

class ViewController: NSViewController, NSWindowDelegate {
    
    @IBAction func guessMenuBar(_ sender: NSMenuItem) {
        self.tryGuess()
    }
    
    @IBAction func resetMenuBar(_ sender: NSMenuItem) {
        self.resetGame(minRange: minNumber, maxRange: maxNumber)
    }
    
    @IBAction func prefsMenuItem(_ sender: NSMenuItem) {
        showPrefs(self)
    }
    
    @IBOutlet weak var guessInput: NSTextField!
    
    @IBOutlet weak var guideLabel: NSTextField!
    
    @IBOutlet weak var triesLabel: NSTextField!
    
    @IBOutlet weak var feedbackLabel: NSTextField!
    
    @IBAction func guessButton(_ sender: Any) {
        self.tryGuess()
    }
    
    @IBAction func resetButton(_ sender: Any) {
        self.resetGame(minRange: minNumber, maxRange: maxNumber)
    }
    
    @IBAction func prefsButton(_ sender: Any) {
        self.showPrefs(self)
    }
    
    var triesEnabled = false
    var minNumber = 0
    var maxNumber = 20
    var maxTries = 3

    var numberToBeGuessed = 0
    var gameFinished = false
    var tries = 0
    
    func tryGuess() {
        let guess = guessInput.stringValue
        if (gameFinished) {
            return
        }
        if (!guess.isInt) {
            feedbackLabel.stringValue = "You have to enter a number!"
            return
        }
        let guessInt = guessInput.intValue
        if (guessInt == numberToBeGuessed) {
            feedbackLabel.stringValue = "Correct! The random number was \(numberToBeGuessed)."
            gameFinished = true
        }
        else if (guessInt > numberToBeGuessed) {
            feedbackLabel.stringValue = "Too big. The number is lower than \(guessInt)."
        }
        else if (guessInt < numberToBeGuessed) {
            feedbackLabel.stringValue = "Too low. The number is bigger than \(guessInt)."
        }
        else {
            print("guessInt: \(guessInt) numberToBeGuessed: \(numberToBeGuessed) guessInput: \(guessInput.stringValue)")
            feedbackLabel.stringValue = "Unknown error."
            return
        }
        self.updateTries()
        if (triesEnabled && tries <= 0 && !gameFinished) {
            feedbackLabel.stringValue = "You lost! You used up all your tries. The correct number was \(numberToBeGuessed)."
            gameFinished = true
        }
    }
    
    func genRandomNumber(firstNum: Int, secondNum: Int) {
        numberToBeGuessed = Int.random(in: firstNum...secondNum)
        if (triesEnabled) {
            tries = maxTries
            triesLabel.stringValue = "Tries left: \(tries)"
        }
        else {
            tries = 0
            triesLabel.stringValue = "Times guessed: \(tries)"
        }
        guideLabel.stringValue = "A random number between \(firstNum) and \(secondNum) has been generated. Can you guess it?"
        feedbackLabel.stringValue = "To guess, type a number in the text field and press the \"Guess\" button."
    }
    
    func updateTries() {
        if (triesEnabled) {
            tries -= 1
            triesLabel.stringValue = "Tries left: \(tries)"
        }
        else {
            tries += 1
            triesLabel.stringValue = "Times guessed: \(tries)"
        }
    }
    
    func resetGame(minRange: Int, maxRange: Int) {
        gameFinished = false
        self.genRandomNumber(firstNum: minRange, secondNum: maxRange)
    }
    
    func applyPrefs(applyMinNum: Int, applyMaxNum: Int, applyTriesOn: Bool, applyMaxTries: Int) {
        minNumber = applyMinNum
        maxNumber = applyMaxNum
        triesEnabled = applyTriesOn
        maxTries = applyMaxTries
        resetGame(minRange: minNumber, maxRange: maxNumber)
    }
    
    func showPrefs(_ sender: AnyObject) {
        let thisSB = NSStoryboard(name: "Main", bundle: nil)
        let prefsVC: PrefsViewController = thisSB.instantiateController(withIdentifier: "prefsViewController") as! PrefsViewController
        prefsVC.prefsDelegate = self
        self.presentAsSheet(prefsVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.resetGame(minRange: minNumber, maxRange: maxNumber)
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

