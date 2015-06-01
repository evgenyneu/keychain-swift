import Security

/**

These options are used to determine when a keychain item should be readable. The default value is AccessibleWhenUnlocked.

*/
public enum KeychainSwiftAccessOptions {
  
  /**
  
  The data in the keychain item can be accessed only while the device is unlocked by the user.
  
  This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute migrate to a new device when using encrypted backups.
  
  This is the default value for keychain items added without explicitly setting an accessibility constant.
  
  */
  case AccessibleWhenUnlocked
  
  /**
  
  The data in the keychain item can be accessed only while the device is unlocked by the user.
  
  This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
  
  */
  case AccessibleWhenUnlockedThisDeviceOnly
  
  /**
  
  The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
  
  After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute migrate to a new device when using encrypted backups.
  
  */
  case AccessibleAfterFirstUnlock
  
  /**
  
  The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
  
  After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
  
  */
  case AccessibleAfterFirstUnlockThisDeviceOnly
  
  /**
  
  The data in the keychain item can always be accessed regardless of whether the device is locked.
  
  This is not recommended for application use. Items with this attribute migrate to a new device when using encrypted backups.
  
  */
  case AccessibleAlways
  
  /**
  
  The data in the keychain can only be accessed when the device is unlocked. Only available if a passcode is set on the device.
  
  This is recommended for items that only need to be accessible while the application is in the foreground. Items with this attribute never migrate to a new device. After a backup is restored to a new device, these items are missing. No items can be stored in this class on devices without a passcode. Disabling the device passcode causes all items in this class to be deleted.
  
  */
  case AccessibleWhenPasscodeSetThisDeviceOnly
  
  /**
  
  The data in the keychain item can always be accessed regardless of whether the device is locked.
  
  This is not recommended for application use. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
  
  */
  case AccessibleAlwaysThisDeviceOnly
  
  static var defaultOption: KeychainSwiftAccessOptions {
    return .AccessibleWhenUnlocked
  }
  
  var value: String {
    switch self {
    case .AccessibleWhenUnlocked:
      return toString(kSecAttrAccessibleWhenUnlocked)
      
    case .AccessibleWhenUnlockedThisDeviceOnly:
      return toString(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
      
    case .AccessibleAfterFirstUnlock:
      return toString(kSecAttrAccessibleAfterFirstUnlock)
      
    case .AccessibleAfterFirstUnlockThisDeviceOnly:
      return toString(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
      
    case .AccessibleAlways:
      return toString(kSecAttrAccessibleAlways)
      
    case .AccessibleWhenPasscodeSetThisDeviceOnly:
      return toString(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
      
    case .AccessibleAlwaysThisDeviceOnly:
      return toString(kSecAttrAccessibleAlwaysThisDeviceOnly)
    }
  }
  
  func toString(value: CFStringRef) -> String {
    return KeychainSwiftConstants.toString(value)
  }
}