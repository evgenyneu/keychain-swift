import Security
import Foundation
import KeychainSwift // You might need to remove this import in your project

/**
 
 This file can be used in your ObjC project if you want to use KeychainSwift Swift library.
 Extend this file to add other functionality for your app.
 
 How to use
 ----------
 
 1. Import swift code in your ObjC file:
 
 #import "YOUR_PRODUCT_MODULE_NAME-Swift.h"
 
 2. Use KeychainSwift in your ObjC code:
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 KeychainSwiftCBridge *keychain = [[KeychainSwiftCBridge alloc] init];
 [keychain set:@"Hello World" forKey:@"my key"];
 NSString *value = [keychain get:@"my key"];
 
 3. You might need to remove `import KeychainSwift` import from this file in your project.
 
*/
@objc public class KeychainSwiftCBridge: NSObject {
  let keychain = KeychainSwift()
  
  open var lastResultCode: OSStatus {
    get { return keychain.lastResultCode }
  }
  
  open var accessGroup: String? {
    set { keychain.accessGroup = newValue }
    get { return keychain.accessGroup }
  }
  
  open var synchronizable: Bool {
    set { keychain.synchronizable = newValue }
    get { return keychain.synchronizable }
  }
  
  
  @discardableResult
  open func set(_ value: String, forKey key: String) -> Bool {
    return keychain.set(value, forKey: key)
  }
  
  @discardableResult
  open func setData(_ value: Data, forKey key: String) -> Bool {
    return keychain.set(value, forKey: key)
  }
  
  @discardableResult
  open func setBool(_ value: Bool, forKey key: String) -> Bool {
    return keychain.set(value, forKey: key)
  }
  
  open func get(_ key: String) -> String? {
    return keychain.get(key)
  }
  
  open func getData(_ key: String) -> Data? {
    return keychain.getData(key)
  }
  
  open func getBool(_ key: String) -> Bool? {
    return keychain.getBool(key)
  }
  
  @discardableResult
  open func delete(_ key: String) -> Bool {
    return keychain.delete(key);
  }
  
  @discardableResult
  open func clear() -> Bool {
    return keychain.clear()
  }
}
