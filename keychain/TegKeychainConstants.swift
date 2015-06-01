import Foundation
import Security

public struct TegKeychainConstants {
  public static var klass: String { return toString(kSecClass) }
  public static var classGenericPassword: String { return toString(kSecClassGenericPassword) }
  public static var attrAccount: String { return toString(kSecAttrAccount) }
  public static var valueData: String { return toString(kSecValueData) }
  public static var returnData: String { return toString(kSecReturnData) }
  public static var matchLimit: String { return toString(kSecMatchLimit) }
  
  
  /**
  
  A value that indicates when your app needs access to the data in a keychain item. The default value is AccessibleWhenUnlocked. For a list of possible values, see TegKeychainAccessibilityConstants.
  
  */
  public static var accessible: String { return toString(kSecAttrAccessible) }

  private static func toString(value: CFStringRef) -> String {
    return (value as? String) ?? ""
  }
}


/**

These constants are values for TegKeychainConstants.accessible used for determining when a keychain item should be readable. The default value is AccessibleWhenUnlocked.

*/
struct TegKeychainAccessibilityConstants {
  

  

  
  
}


/**

These constants are values for TegKeychainConstants.accessible used for determining when a keychain item should be readable. The default value is AccessibleWhenUnlocked.

*/
public enum TegKeychainAccessibilityOptions {
  
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
    return (value as? String) ?? ""
  }
}


