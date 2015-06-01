# iOS/Swift helper functions for storing text in Keychain

This is a collection of helper functions for saving text and data in the Keychain.
 As you probably noticed Apple's keychain API is a bit verbose. This class was designed to provide shorter syntax for accomplishing a simple task: reading/writing text values for specified keys. Tested in iOS 7 and 8.

## What's Keychain?

Keychain is a secure storage on iOS device. You can store all kind of sensitive data in it: user passwords, credit card numbers, secret tokens etc. Once stored in Keychain this information is only available to your app, other apps can't see it. Besides that, iOS makes sure this information is kept and processed securely. For example, text stored in Keychain can not be extracted from iPhone backup or from its file system.

## Setup

There are three ways you can add KeychainSwift to your Xcode project.

**Add source (iOS 7+)**

Simply add [KeychainSwiftDistrib.swift](https://github.com/exchangegroup/keychain-swift/blob/master/Distrib/KeychainSwiftDistrib.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Alternatively, add `github "exchangegroup/keychain-swift" ~> 0.1` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'KeychainSwift', '~> 0.1'

## Usage

Add `import KeychainSwift` to your source code if you used Carthage or CocoaPods setup methods.

```Swift
KeychainSwift.set("hello world", forKey: "my key")

KeychainSwift.get("my key")

KeychainSwift.delete("my key")

KeychainSwift.clear() // delete everything from app's Keychain
```

In addition to strings one can set/get `NSData` objects.

```Swift
KeychainSwift.set(nsDataObject, forKey: "my key")

KeychainSwift.getData("my key")
```

## Advanced options

### Keychain item access

Use `withAccess` attribute to specify when your app needs access to the text in the keychain item.
By default the `.AccessibleWhenUnlocked` option is used. It is recommended to use most restrictive option that is suitable for you app in order provide the best data protection.

```
KeychainSwift.set("Hello world", forKey: "key 1", withAccess: .AccessibleWhenUnlocked)
```

You can use `.AccessibleAfterFirstUnlock` if you need your app to access the keychain item while in the background. It may be needed for the Apple Watch apps.

See the list of all available [access options](https://github.com/exchangegroup/keychain-swift/blob/master/keychain/KeychainSwiftAccessOptions.swift).

## Demo app

<img src="https://raw.githubusercontent.com/exchangegroup/keychain-swift/master/graphics/keychain-swift-demo.png" alt="Sacing and reading text from Keychaing in iOS and Swift" width="320">

### Reference

The code is based on this example: [https://gist.github.com/s-aska/e7ad24175fb7b04f78e7](https://gist.github.com/s-aska/e7ad24175fb7b04f78e7)

### Repository home

https://github.com/exchangegroup/keychain-swift
