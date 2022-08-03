import UIKit
import KeychainSwift

let TegKeychainDemo_keyName = "my key"

class ViewController: UIViewController {

	@IBOutlet weak var keyTextField: UITextField!
	@IBOutlet weak var serviceNameTextField: UITextField!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var valueLabel: UILabel!
  @IBOutlet weak var synchronizableSwitch: UISwitch!
  
	let keychain = KeychainSwift()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateValueLabel()
  }
  
  @IBAction func onSaveTapped(_ sender: AnyObject) {
    closeKeyboard()

		setServiceName()
    
    if let text = textField.text {
      keychain.synchronizable = synchronizableSwitch.isOn
			keychain.set(text, forKey: keyTextField.text ?? TegKeychainDemo_keyName)
      updateValueLabel()
    }
  }
  
  @IBAction func onDeleteTapped(_ sender: AnyObject) {
    closeKeyboard()
		setServiceName()
    keychain.synchronizable = synchronizableSwitch.isOn
    keychain.delete(keyTextField.text ?? TegKeychainDemo_keyName)
    updateValueLabel()
  }
  
  @IBAction func onGetTapped(_ sender: AnyObject) {
    closeKeyboard()
		setServiceName()
    updateValueLabel()
  }


	@IBAction func onReadAllTapped(_ sender: AnyObject) {
		closeKeyboard()
		setServiceName()
		let allKeys = keychain.allKeys.joined(separator: "\n")
		valueLabel.text = "Keys currently in keychain:\n\n\(allKeys)"
	}

  private func updateValueLabel() {
    keychain.synchronizable = synchronizableSwitch.isOn
    
    if let value = keychain.get(keyTextField.text ?? TegKeychainDemo_keyName) {
      valueLabel.text = "In Keychain: \(value)"
    } else {
      valueLabel.text = "no value in keychain"
    }
  }
  
  private func closeKeyboard() {
    textField.resignFirstResponder()
  }

	private func setServiceName() {
		if let serviceName = serviceNameTextField.text, !serviceName.isEmpty {
			keychain.serviceName = serviceName
		} else {
			keychain.serviceName = nil
		}
	}
  
  @IBAction func didTapView(_ sender: AnyObject) {
    closeKeyboard()
  }
}
