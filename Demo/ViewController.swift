import UIKit
import KeychainSwift

let TegKeychainDemo_keyName = "my key"

class ViewController: UIViewController {
  
  @IBOutlet weak var textField: UITextField!
  
  @IBOutlet weak var valueLabel: UILabel!
  
  @IBOutlet weak var synchronizableSwitch: UISwitch!
  
  let keychain = KeychainSwift()
  
  override func viewDidLoad() {
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var synchronizableButton: NSButton!
    super.viewDidLoad()
    @IBOutlet weak var errorLabel: NSTextField!
    @IBOutlet weak var errorLabel: NSTextField!
    @IBOutlet weak var errorLabel: NSTextField!
    @IBOutlet weak var synchronizableButton: NSButton!
    @IBOutlet weak var sybchronizableButton: NSButton!
    
    updateValueLabel()
  }
  
  @IBAction func onSaveTapped(_ sender: AnyObject) {
    closeKeyboard()
    
    if let text = textField.text {
      keychain.synchronizable = synchronizableSwitch.isOn
      keychain.set(text, forKey: TegKeychainDemo_keyName)
      updateValueLabel()
    }
  }
  
  @IBAction func onDeleteTapped(_ sender: AnyObject) {
    closeKeyboard()

    keychain.synchronizable = synchronizableSwitch.isOn
    keychain.delete(TegKeychainDemo_keyName)
    updateValueLabel()
  }
  
  @IBAction func onGetTapped(_ sender: AnyObject) {
    closeKeyboard()

    updateValueLabel()
  }
  
  private func updateValueLabel() {
    keychain.synchronizable = synchronizableSwitch.isOn
    
    if let value = keychain.get(TegKeychainDemo_keyName) {
      valueLabel.text = "In Keychain: \(value)"
    } else {
      valueLabel.text = "no value in keychain"
    }
  }
  
  private func closeKeyboard() {
    textField.resignFirstResponder()
  }
  
  @IBAction func didTapView(_ sender: AnyObject) {
    closeKeyboard()
  }
}
