import Foundation
import Security

public struct KeychainSwiftConstants {
  public static var klass: String { return toString(kSecClass) }
  public static var classGenericPassword: String { return toString(kSecClassGenericPassword) }
  public static var attrAccount: String { return toString(kSecAttrAccount) }
  public static var valueData: String { return toString(kSecValueData) }
  public static var returnData: String { return toString(kSecReturnData) }
  public static var matchLimit: String { return toString(kSecMatchLimit) }

  /**
  
  A value that indicates when your app needs access to the data in a keychain item. The default value is AccessibleWhenUnlocked. For a list of possible values, see KeychainSwiftAccessOptions.
  
  */
  public static var accessible: String { return toString(kSecAttrAccessible) }

  static func toString(value: CFStringRef) -> String {
    return value as String
  }
}


