//
//  KeychainSwiftAccessControlFlag.swift
//  KeychainSwift
//
//  Created by Salman Soumik on 3/9/22.
//  Copyright © 2022 Evgenii Neumerzhitckii. All rights reserved.
//

import Security

/**

These flags are used to determine when a keychain item should be readable. The default value is userPresence.

*/
public enum KeychainSwiftAccessControlFlag {
  
  /**
  
   Constraint: Touch ID (any finger) or Face ID. Touch ID or Face ID must be available. With Touch ID
   at least one finger must be enrolled. With Face ID user has to be enrolled. Item is still accessible by Touch ID even
   if fingers are added or removed. Item is still accessible by Face ID if user is re-enrolled.
  
  */
  case biometryAny
  
  /**
  
   Constraint: Touch ID from the set of currently enrolled fingers. Touch ID must be available and at least one finger must
   be enrolled. When fingers are added or removed, the item is invalidated. When Face ID is re-enrolled this item is invalidated.
  
  */
  case biometryCurrentSet
  
  /**
   User presence policy using biometry or Passcode. Biometry does not have to be available or enrolled. Item is still
   accessible by Touch ID even if fingers are added or removed. Item is still accessible by Face ID if user is re-enrolled.
  
  */
  case userPresence
  
  /**
  
   Constraint: Device passcode
  
  */
  case devicePasscode


  
  static var defaultOption: KeychainSwiftAccessControlFlag {
    return .userPresence
  }
  
  var value: SecAccessControlCreateFlags {
    switch self {
    case .biometryAny:
        return .biometryAny
      
    case .biometryCurrentSet:
        return .biometryCurrentSet
      
    case .userPresence:
        return .userPresence
      
    case .devicePasscode:
        return .devicePasscode
    }
  }
}
