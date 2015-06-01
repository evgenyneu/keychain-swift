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
    TegKeychain.set(textField.text, forKey: TegKeychainDemo_keyName)
    updateValueLabel()
  }

  @IBAction func onDeleteTapped(sender: AnyObject) {
    TegKeychain.delete(TegKeychainDemo_keyName)
    updateValueLabel()
  }
  
  private func updateValueLabel() {
    if let value = TegKeychain.get(TegKeychainDemo_keyName) {
      valueLabel.text = "In Keychain: \(value)"
    } else {
      valueLabel.text = "no value in keychain"
    }
  }
  
}

