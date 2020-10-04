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
        //print("closing preferences...")
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
        
        //print("minNumTextField: \(prefsMinNum) maxNumTextField: \(prefsMaxNum) triesCheckBox: \(prefsTriesEnabled) triesTextField: \(prefsMaxTries)")
        //print("applying prefs...")
        prefsDelegate.sendPrefValues(sendMinNum: prefsMinNum, sendMaxNum: prefsMaxNum, sendTriesOn: prefsTriesEnabled, sendMaxTries: prefsMaxTries)
        //print("dismissing prefs view...")
        self.dismiss(self)
        //print("prefs applied")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
