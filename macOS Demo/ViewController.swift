import Cocoa
import KeychainSwift

let TegKeychainDemo_keyName = "my key"

class ViewController: NSViewController {
  
  @IBOutlet weak var textField: NSTextField!
  
  @IBOutlet weak var valueLabel: NSTextField!
  
  @IBOutlet weak var errorLabel: NSTextField!
  
  @IBOutlet weak var synchronizableButton: NSButton!
  
  let keychain = KeychainSwift()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    updateValueLabel()
    errorLabel.stringValue = ""
  }
  
//  override var representedObject: Any? {
//    didSet {
//    // Update the view, if already loaded.
//    }
//  }

  @IBAction func onSaveTapped(_ sender: AnyObject) {
    keychain.synchronizable = synchronizableButton.state == NSControl.StateValue.on
    keychain.set(textField.stringValue, forKey: TegKeychainDemo_keyName)
    errorLabel.stringValue = "Result code: \(keychain.lastResultCode)"
    updateValueLabel()
  }
  
  
  @IBAction func onDeleteTapped(_ sender: AnyObject) {
    keychain.synchronizable = synchronizableButton.state == NSControl.StateValue.on
    keychain.delete(TegKeychainDemo_keyName)
    errorLabel.stringValue = "Result code: \(keychain.lastResultCode)"
    updateValueLabel()
  }
  
  @IBAction func onGetTapped(_ sender: AnyObject) {
    updateValueLabel()
  }
  
  private func updateValueLabel() {
    keychain.synchronizable = synchronizableButton.state == NSControl.StateValue.on

    if let value = keychain.get(TegKeychainDemo_keyName) {
      valueLabel.stringValue = "In Keychain: \(value)"
    } else {
      valueLabel.stringValue = "no value in keychain"
    }
  }

}

