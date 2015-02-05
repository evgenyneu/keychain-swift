//
//  ViewController.swift
//  keychain
//
//  Created by Evgenii Neumerzhitckii on 5/02/2015.
//  Copyright (c) 2015 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  
  @IBOutlet weak var valueLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onSaveTapped(sender: AnyObject) {
    
  }

  @IBAction func onDeleteTapped(sender: AnyObject) {
  }
  
}

