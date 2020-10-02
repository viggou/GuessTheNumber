//
//  PrefsViewController.swift
//  Guess The Number
//
//  Created by Viggo Lekdorf on 02/10/2020.
//

import Cocoa

class PrefsViewController: NSViewController {

    
    @IBAction func closeButton(_ sender: Any) {
        print("close preferences")
        self.dismiss(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
