import UIKit
import Security

public class TegKeychain {
  
  public class func set(key: String, value: String) -> Bool {
    if let data = value.dataUsingEncoding(NSUTF8StringEncoding) {
      return set(key, value: data)
    }
    
    return false
  }

  public class func set(key: String, value: NSData) -> Bool {
    let query = [
      TegKeychainConstants.klass       : TegKeychainConstants.classGenericPassword,
      TegKeychainConstants.attrAccount : key,
      TegKeychainConstants.valueData   : value ]
    
    SecItemDelete(query as CFDictionaryRef)
    
    let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
    
    return status == noErr
  }

  public class func get(key: String) -> String? {
    if let data = getData(key),
      let currentString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {

      return currentString
    }

    return nil
  }

  public class func getData(key: String) -> NSData? {
    let query = [
      TegKeychainConstants.klass       : kSecClassGenericPassword,
      TegKeychainConstants.attrAccount : key,
      TegKeychainConstants.returnData  : kCFBooleanTrue,
      TegKeychainConstants.matchLimit  : kSecMatchLimitOne ]
    
    var result: AnyObject?
    
    let status = withUnsafeMutablePointer(&result) {
      SecItemCopyMatching(query, UnsafeMutablePointer($0))
    }
    
    if status == noErr { return result as? NSData }
    
    return nil
  }

  public class func delete(key: String) -> Bool {
    let query = [
      TegKeychainConstants.klass       : kSecClassGenericPassword,
      TegKeychainConstants.attrAccount : key ]
    
    let status: OSStatus = SecItemDelete(query as CFDictionaryRef)
    
    return status == noErr
  }

  public class func clear() -> Bool {
    let query = [ kSecClass as String : kSecClassGenericPassword ]
    
    let status: OSStatus = SecItemDelete(query as CFDictionaryRef)
    
    return status == noErr
  }
}