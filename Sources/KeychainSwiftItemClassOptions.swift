//
//  KeychainSwiftItemClassOptions.swift
//  KeychainSwift
//
//  Created by Oleynik Gennady on 26/01/2019.
//  Copyright © 2019 Marketplacer. All rights reserved.
//


/**
    Keychain items come in a variety of classes according to the kind of data they hold, such as passwords, cryptographic keys, and certificates. The item's class dictates which attributes apply and enables the system to decide whether or not the data should be encrypted on disk. For example, passwords require encryption, but certificates don't because they are not secret.
 */

/**
    KeychainSwiftItemClassOptions is an wrapper on system kSecClass values
 */

public enum KeychainSwiftItemClassOptions {
    case genericPassword
    case internetPassword
    case certificate
    case key
    case identity
    
    public static var defaultOption: KeychainSwiftItemClassOptions {
        return .genericPassword
    }
    
    var value: CFString {
        switch self {
        case .genericPassword:
            return kSecClassGenericPassword
        case .internetPassword:
            return kSecClassInternetPassword
        case .certificate:
            return kSecClassCertificate
        case .key:
            return kSecClassKey
        case .identity:
            return kSecClassIdentity
        }
    }
}
