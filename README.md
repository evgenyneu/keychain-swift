# iOS/Swift helper functions for storing text in Keychain

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/KeychainSwift.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/KeychainSwift.svg?style=flat)][cocoadocs]
[![Platform](https://img.shields.io/cocoapods/p/KeychainSwift.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/KeychainSwift
[carthage]: https://github.com/Carthage/Carthage

This is a collection of helper functions for saving text and data in the Keychain.
 As you probably noticed Apple's keychain API is a bit verbose. This library was designed to provide shorter syntax for accomplishing a simple task: reading/writing text values for specified keys. Tested in iOS 7 and 8.

## What's Keychain?

Keychain is a secure storage on iOS device. You can store all kind of sensitive data in it: user passwords, credit card numbers, secret tokens etc. Once stored in Keychain this information is only available to your app, other apps can't see it. Besides that, iOS makes sure this information is kept and processed securely. For example, text stored in Keychain can not be extracted from iPhone backup or from its file system.

## Setup

There are three ways you can add KeychainSwift to your Xcode project.

**Add source (iOS 7+)**

Simply add [KeychainSwiftDistrib.swift](https://github.com/exchangegroup/keychain-swift/blob/master/Distrib/KeychainSwiftDistrib.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Alternatively, add `github "exchangegroup/keychain-swift" ~> 3.0` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'KeychainSwift', '~> 3.0'


**Setup in Swift 1.2 project**

Use the [previous version of the library](https://github.com/exchangegroup/keychain-swift/wiki/Swift-1.2-setup).

## Usage

Add `import KeychainSwift` to your source code if you used Carthage or CocoaPods setup methods.

```Swift
let keychain = KeychainSwift()

keychain.set("hello world", forKey: "my key")

keychain.get("my key")

keychain.delete("my key")

keychain.clear() // delete everything from app's Keychain
```

In addition to strings one can set/get `NSData` objects.

```Swift
let keychain = KeychainSwift()

keychain.set(nsDataObject, forKey: "my key")

keychain.getData("my key")
```

## Advanced options

### Keychain item access

Use `withAccess` parameter to specify the security level of the keychain storage.
By default the `.AccessibleWhenUnlocked` option is used. It is one of the most restrictive options and provides good data protection.

```
KeychainSwift().set("Hello world", forKey: "key 1", withAccess: .AccessibleWhenUnlocked)
```

You can use `.AccessibleAfterFirstUnlock` if you need your app to access the keychain item while in the background.  It may be needed for the Apple Watch apps. Note that it is less secure than the `.AccessibleWhenUnlocked` option.

See the list of all available [access options](https://github.com/exchangegroup/keychain-swift/blob/master/KeychainSwift/KeychainSwiftAccessOptions.swift).

### Setting key prefix

One can pass a `keyPrefix` argument when initializing a `KeychainSwift` object. The string passed in `keyPrefix` argument will be used as a prefix to the keys supplied in set, get, getData and delete methods. I use the prefixed keychain in tests. This prevents the tests from changing the Keychain keys that are used when the app is launched manually.

Note that `clear` method still clears everything from the Keychain regardless of the prefix used.

```Swift
let keychain = KeychainSwift(keyPrefix: "myTestKey_")
```

## Demo app

<img src="https://raw.githubusercontent.com/exchangegroup/keychain-swift/master/graphics/keychain-swift-demo.png" alt="Sacing and reading text from Keychaing in iOS and Swift" width="320">

## Credits

The code is based on this example: [https://gist.github.com/s-aska/e7ad24175fb7b04f78e7](https://gist.github.com/s-aska/e7ad24175fb7b04f78e7)

## License

Keychain Swift is released under the [MIT License](LICENSE).
