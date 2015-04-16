import Foundation
import Security

struct TegKeychainConstants {
  static var klass: String { return toString(kSecClass) }
  static var classGenericPassword: String { return toString(kSecClassGenericPassword) }
  static var attrAccount: String { return toString(kSecAttrAccount) }
  static var valueData: String { return toString(kSecValueData) }
  static var returnData: String { return toString(kSecReturnData) }
  static var matchLimit: String { return toString(kSecMatchLimit) }

  private static func toString(value: CFStringRef) -> String {
    return (value as? String) ?? ""
  }
}
