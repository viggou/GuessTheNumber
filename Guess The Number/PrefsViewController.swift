//
//  PrefsViewController.swift
//  Guess The Number
//
//  Created by Viggo Lekdorf on 02/10/2020.
//

import Cocoa

protocol PrefsDelegate {
    func sendPrefValues(sendMinNum: Int, sendMaxNum: Int, sendTriesOn: Bool, sendMaxTries: Int)
}

class PrefsViewController: NSViewController {
    
    var prefsDelegate: PrefsDelegate!

    @IBOutlet weak var minNumTextField: NSTextField!
    
    @IBOutlet weak var maxNumTextField: NSTextField!
    
    @IBOutlet weak var triesTextField: NSTextField!
    
    var triesOn = false
    
    @IBAction func triesCheckBox(_ sender: AnyObject) {
        if (sender.state == .on) {
            triesTextField.isEnabled = true
            triesOn = true
        }
        else if (sender.state == .off) {
            triesTextField.isEnabled = false
            triesOn = false
        }
    }
    
    var prefsMinNum: Int = 0
    var prefsMaxNum: Int = 20
    var prefsTriesEnabled: Bool = false
    var prefsMaxTries: Int = 3
    
    @IBAction func closeButton(_ sender: Any) {
        if (!minNumTextField.stringValue.isInt || !maxNumTextField.stringValue.isInt || !triesTextField.stringValue.isInt) {
            let alert = NSAlert()
            alert.messageText = "Error"
            alert.informativeText = "You can only enter (whole) numbers in the text fields."
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
            return
        }
        
        prefsMinNum = Int(minNumTextField.intValue)
        prefsMaxNum = Int(maxNumTextField.intValue)
        prefsTriesEnabled = triesOn
        prefsMaxTries = Int(triesTextField.intValue)
        
        if (prefsMinNum >= prefsMaxNum) {
            let alert = NSAlert()
            alert.messageText = "Error"
            alert.informativeText = "Minimum number can't be bigger than or equal to the maximum number."
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
            return
        }
        
        if (prefsTriesEnabled && prefsMaxTries <= 0) {
            let alert = NSAlert()
            alert.messageText = "Error"
            alert.informativeText = "Tries must be bigger than 0."
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
            return
        }
        
        prefsDelegate.sendPrefValues(sendMinNum: prefsMinNum, sendMaxNum: prefsMaxNum, sendTriesOn: prefsTriesEnabled, sendMaxTries: prefsMaxTries)
        self.dismiss(self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
