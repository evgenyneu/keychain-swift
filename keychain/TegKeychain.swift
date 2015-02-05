//
//  TegKeychain.swift
//  keychain
//
//  Created by Evgenii Neumerzhitckii on 5/02/2015.
//  Copyright (c) 2015 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit
import Security

class TegKeychain {
  
  class func set(key: String, value: String) -> Bool {
    if let currentData = value.dataUsingEncoding(NSUTF8StringEncoding) {
      return set(key, value: currentData)
    }
    
    return false
  }
  
  class func set(key: String, value: NSData) -> Bool {
    let query = [
      kSecClass as String       : kSecClassGenericPassword as String,
      kSecAttrAccount as String : key,
      kSecValueData as String   : value ]
    
    SecItemDelete(query as CFDictionaryRef)
    
    let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
    
    return status == noErr
  }
  
  class func getString(key: String) -> String? {
    if let currentData = getData(key) {
      return NSString(data: currentData, encoding: NSUTF8StringEncoding)
    }
    
    return nil
  }
  
  
  class func getData(key: String) -> NSData? {
    let query = [
      kSecClass as String       : kSecClassGenericPassword,
      kSecAttrAccount as String : key,
      kSecReturnData as String  : kCFBooleanTrue,
      kSecMatchLimit as String  : kSecMatchLimitOne ]
    
    var dataTypeRef :Unmanaged<AnyObject>?
    
    let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)
    
    if status == noErr {
      if let currentDataTypeRef = dataTypeRef {
        return currentDataTypeRef.takeRetainedValue() as? NSData
      }
    }
    
    return nil
  }
  
  class func delete(key: String) -> Bool {
    let query = [
      kSecClass as String       : kSecClassGenericPassword,
      kSecAttrAccount as String : key ]
    
    let status: OSStatus = SecItemDelete(query as CFDictionaryRef)
    
    return status == noErr
  }
  
  
  class func clear() -> Bool {
    let query = [ kSecClass as String : kSecClassGenericPassword ]
    
    let status: OSStatus = SecItemDelete(query as CFDictionaryRef)
    
    return status == noErr
  }
  
}