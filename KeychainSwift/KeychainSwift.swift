import Security
import Foundation

/**

A collection of helper functions for saving text and data in the keychain.

*/
public class KeychainSwift {
  
  var lastQueryParameters: [String: NSObject]? // Used by the unit tests
  
  /// Contains result code from the last operation. Value is noErr (0) for a successful result.
  public var lastResultCode: OSStatus = noErr

  var keyPrefix = "" // Can be useful in test.
  
  /**

  Specify an access group that will be used to access keychain items. Access groups can be used to share keychain items between applications. When access group value is nil all application access groups are being accessed. Access group name is used by all functions: set, get, delete and clear.

  */
  public var accessGroup: String?
  
  /// Instantiate a KeychainSwift object
  public init() { }
  
  /**
  
  - parameter keyPrefix: a prefix that is added before the key in get/set methods. Note that `clear` method still clears everything from the Keychain.

  */
  public init(keyPrefix: String) {
    self.keyPrefix = keyPrefix
  }
  
  /**
  
  Stores the text value in the keychain item under the given key.
  
  - parameter key: Key under which the text value is stored in the keychain.
  - parameter value: Text string to be written to the keychain.
  - parameter withAccess: Value that indicates when your app needs access to the text in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
   
   - returns: True if the text was successfully written to the keychain.

  */
  public func set(value: String, forKey key: String,
    withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
    
    if let value = value.dataUsingEncoding(NSUTF8StringEncoding) {
      return set(value, forKey: key, withAccess: access)
    }
    
    return false
  }

  /**
  
  Stores the data in the keychain item under the given key.
  
  - parameter key: Key under which the data is stored in the keychain.
  - parameter value: Data to be written to the keychain.
  - parameter withAccess: Value that indicates when your app needs access to the text in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
  
  - returns: True if the text was successfully written to the keychain.
  
  */
  public func set(value: NSData, forKey key: String,
    withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
    
    delete(key) // Delete any existing key before saving it

    let accessible = access?.value ?? KeychainSwiftAccessOptions.defaultOption.value
      
    let prefixedKey = keyWithPrefix(key)
      
    var query = [
      KeychainSwiftConstants.klass       : kSecClassGenericPassword,
      KeychainSwiftConstants.attrAccount : prefixedKey,
      KeychainSwiftConstants.valueData   : value,
      KeychainSwiftConstants.accessible  : accessible
    ]
      
    query = addAccessGroupWhenPresent(query)
    lastQueryParameters = query
    
    lastResultCode = SecItemAdd(query as CFDictionaryRef, nil)
    
    return lastResultCode == noErr
  }

  /**

  Stores the boolean value in the keychain item under the given key.

  - parameter key: Key under which the value is stored in the keychain.
  - parameter value: Boolean to be written to the keychain.
  - parameter withAccess: Value that indicates when your app needs access to the value in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.

  - returns: True if the value was successfully written to the keychain.

  */
  public func set(value: Bool, forKey key: String,
    withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {

    var localValue = value
    let data = NSData(bytes: &localValue, length: sizeof(Bool))
    return set(data, forKey: key, withAccess: access)
  }

  /**
  
  Retrieves the text value from the keychain that corresponds to the given key.
  
  - parameter key: The key that is used to read the keychain item.
  - returns: The text value from the keychain. Returns nil if unable to read the item.
  
  */
  public func get(key: String) -> String? {
    if let data = getData(key) {
      if let currentString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
        return currentString
      }
      
      lastResultCode = -67853 // errSecInvalidEncoding
    }

    return nil
  }

  /**
  
  Retrieves the data from the keychain that corresponds to the given key.
  
  - parameter key: The key that is used to read the keychain item.
  - returns: The text value from the keychain. Returns nil if unable to read the item.
  
  */
  public func getData(key: String) -> NSData? {
    let prefixedKey = keyWithPrefix(key)
    
    var query: [String: NSObject] = [
      KeychainSwiftConstants.klass       : kSecClassGenericPassword,
      KeychainSwiftConstants.attrAccount : prefixedKey,
      KeychainSwiftConstants.returnData  : kCFBooleanTrue,
      KeychainSwiftConstants.matchLimit  : kSecMatchLimitOne ]
    
    query = addAccessGroupWhenPresent(query)
    lastQueryParameters = query
    
    var result: AnyObject?
    
    lastResultCode = withUnsafeMutablePointer(&result) {
      SecItemCopyMatching(query, UnsafeMutablePointer($0))
    }
    
    if lastResultCode == noErr { return result as? NSData }
    
    return nil
  }

  /**

  Retrieves the boolean value from the keychain that corresponds to the given key.

  - parameter key: The key that is used to read the keychain item.
  - returns: The boolean value from the keychain. Returns nil if unable to read the item.

  */
  public func getBool(key: String) -> Bool? {
    guard let data = getData(key) else { return nil }
    var boolValue = false
    data.getBytes(&boolValue, length: sizeof(Bool))
    return boolValue
  }

  /**

  Deletes the single keychain item specified by the key.
  
  - parameter key: The key that is used to delete the keychain item.
  - returns: True if the item was successfully deleted.
  
  */
  public func delete(key: String) -> Bool {
    let prefixedKey = keyWithPrefix(key)

    var query: [String: NSObject] = [
      KeychainSwiftConstants.klass       : kSecClassGenericPassword,
      KeychainSwiftConstants.attrAccount : prefixedKey ]
    
    query = addAccessGroupWhenPresent(query)
    lastQueryParameters = query
    
    lastResultCode = SecItemDelete(query as CFDictionaryRef)
    
    return lastResultCode == noErr
  }

  /**
  
  Deletes all Keychain items used by the app. Note that this method deletes all items regardless of the prefix settings used for initializing the class.
  
  - returns: True if the keychain items were successfully deleted.
  
  */
  public func clear() -> Bool {
    var query: [String: NSObject] = [ kSecClass as String : kSecClassGenericPassword ]
    query = addAccessGroupWhenPresent(query)
    lastQueryParameters = query
    
    lastResultCode = SecItemDelete(query as CFDictionaryRef)
    
    return lastResultCode == noErr
  }
  
  /// Returns the key with currently set prefix.
  func keyWithPrefix(key: String) -> String {
    return "\(keyPrefix)\(key)"
  }
  
  func addAccessGroupWhenPresent(items: [String: NSObject]) -> [String: NSObject] {
    guard let accessGroup = accessGroup else { return items }
    
    var result: [String: NSObject] = items
    result[KeychainSwiftConstants.accessGroup] = accessGroup
    return result
  }
}