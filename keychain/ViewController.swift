//
//  ViewController.swift
//  keychain
//
//  Created by Evgenii Neumerzhitckii on 5/02/2015.
//  Copyright (c) 2015 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

let TegKeychainDemo_keyName = "my key"

class ViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  
  @IBOutlet weak var valueLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateValueLabel()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onSaveTapped(sender: AnyObject) {
    TegKeychain.set(TegKeychainDemo_keyName, value: textField.text)
    updateValueLabel()
  }

  @IBAction func onDeleteTapped(sender: AnyObject) {
    TegKeychain.delete(TegKeychainDemo_keyName)
    updateValueLabel()
  }
  
  private func updateValueLabel() {
    if let currentValue = TegKeychain.getString(TegKeychainDemo_keyName) {
      valueLabel.text = "In Keychain: \(currentValue)"
    } else {
      valueLabel.text = "no value in keychain"
    }
  }
  
}

