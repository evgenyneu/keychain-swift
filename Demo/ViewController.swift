import UIKit
import KeychainSwift

let TegKeychainDemo_keyName = "my key"

class ViewController: UIViewController {
  
  @IBOutlet weak var textField: UITextField!
  
  @IBOutlet weak var valueLabel: UILabel!
  
  @IBOutlet weak var synchronizableSwitch: UISwitch!
  
  @IBOutlet weak var userPresenceSwitch: UISwitch!
  
  let keychain = KeychainSwift()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateValueLabel()
  }
  
  @IBAction func onSaveTapped(_ sender: AnyObject) {
    closeKeyboard()
    
    if let text = textField.text {
      keychain.synchronizable = synchronizableSwitch.isOn
      let saved = keychain.set(text,
                               forKey: TegKeychainDemo_keyName,
                               withControlFlags: userPresenceSwitch.isOn ? .userPresence : nil)
      updateValueLabel(withSaved: saved ? text : "Failed to save")
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
  
  private func updateValueLabel(withSaved saved: String? = nil) {
    guard saved == nil else {
      valueLabel.text = "Saved: " + saved!
      return
    }
    
    keychain.synchronizable = synchronizableSwitch.isOn
    
    if let value = keychain.get(TegKeychainDemo_keyName, prompt: "Please, authenticate") {
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
