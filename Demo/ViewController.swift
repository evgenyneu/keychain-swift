import UIKit
import KeychainSwift

let TegKeychainDemo_keyName = "my key"

class ViewController: UIViewController {
  
  @IBOutlet weak var textField: UITextField!
  
  @IBOutlet weak var valueLabel: UILabel!
  
  @IBOutlet weak var synchronizableSwitch: UISwitch!
  
  let keychain = KeychainSwift()
  
  static let accessGroup = "synch keychain group"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateValueLabel()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onSaveTapped(sender: AnyObject) {
    if let text = textField.text {
      keychain.synchronizable = synchronizableSwitch.on
//      keychain.accessGroup = synchronizableSwitch.on ? ViewController.accessGroup : nil
      
      keychain.set(text, forKey: TegKeychainDemo_keyName)
      updateValueLabel()
    }
  }
  
  @IBAction func onDeleteTapped(sender: AnyObject) {
    keychain.synchronizable = synchronizableSwitch.on
//    keychain.accessGroup = synchronizableSwitch.on ? ViewController.accessGroup : nil

    keychain.delete(TegKeychainDemo_keyName)
    updateValueLabel()
  }
  
  @IBAction func onGetTapped(sender: AnyObject) {
    updateValueLabel()
  }
  
  private func updateValueLabel() {
    keychain.synchronizable = synchronizableSwitch.on
//    keychain.accessGroup = synchronizableSwitch.on ? ViewController.accessGroup : nil
    
    if let value = keychain.get(TegKeychainDemo_keyName) {
      valueLabel.text = "In Keychain: \(value)"
    } else {
      valueLabel.text = "no value in keychain"
    }
  }
  
}
