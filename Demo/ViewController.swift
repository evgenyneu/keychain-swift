import UIKit
import KeychainSwift

let TegKeychainDemo_keyName = "my key"

class ViewController: UIViewController {
  
  @IBOutlet weak var textField: UITextField!
  
  @IBOutlet weak var valueLabel: UILabel!
  
  @IBOutlet weak var synchronizableSwitch: UISwitch!
  
  let keychain = KeychainSwift()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateValueLabel()
  }
  
  @IBAction func onSaveTapped(sender: AnyObject) {
    closeKeyboard()
    
    if let text = textField.text {
      keychain.synchronizable = synchronizableSwitch.on
      keychain.set(text, forKey: TegKeychainDemo_keyName)
      updateValueLabel()
    }
  }
  
  @IBAction func onDeleteTapped(sender: AnyObject) {
    closeKeyboard()

    keychain.synchronizable = synchronizableSwitch.on
    keychain.delete(TegKeychainDemo_keyName)
    updateValueLabel()
  }
  
  @IBAction func onGetTapped(sender: AnyObject) {
    closeKeyboard()

    updateValueLabel()
  }
  
  private func updateValueLabel() {
    keychain.synchronizable = synchronizableSwitch.on
    
    if let value = keychain.get(TegKeychainDemo_keyName) {
      valueLabel.text = "In Keychain: \(value)"
    } else {
      valueLabel.text = "no value in keychain"
    }
  }
  
  private func closeKeyboard() {
    textField.resignFirstResponder()
  }
  
  @IBAction func didTapView(sender: AnyObject) {
    closeKeyboard()
  }
}
