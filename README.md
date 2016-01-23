# Helper functions for storing text in Keychain for iOS, OS X, tvOS and WatchOS

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/KeychainSwift.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/KeychainSwift.svg?style=flat)][cocoadocs]
[![Platform](https://img.shields.io/cocoapods/p/KeychainSwift.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/KeychainSwift
[carthage]: https://github.com/Carthage/Carthage

This is a collection of helper functions for saving text and data in the Keychain.
 As you probably noticed Apple's keychain API is a bit verbose. This library was designed to provide shorter syntax for accomplishing a simple task: reading/writing text values for specified keys.

## What's Keychain?

Keychain is a secure storage. You can store all kind of sensitive data in it: user passwords, credit card numbers, secret tokens etc. Once stored in Keychain this information is only available to your app, other apps can't see it. Besides that, operating system makes sure this information is kept and processed securely. For example, text stored in Keychain can not be extracted from iPhone backup or from its file system. Apple recommends storing only small amount of data in the Keychain. If you need to secure something big you can encrypt it manually, save to a file and store the key in the Keychain.

## Setup

There are three ways you can add KeychainSwift to your Xcode project.

**Add source (iOS 7+)**

Simply add [KeychainSwiftDistrib.swift](https://github.com/marketplacer/keychain-swift/blob/master/Distrib/KeychainSwiftDistrib.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Alternatively, add `github "marketplacer/keychain-swift" ~> 3.0` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'KeychainSwift', '~> 3.0'

Here is how to use KeychainSwift in a *WatchKit extension* with CocoaPods.

    use_frameworks!

    target 'YourWatchApp Extension Target Name' do
      platform :watchos, '2.0'
      pod 'KeychainSwift', '~> 3.0'
    end


**Setup in Swift 1.2 project**

Use the [previous version of the library](https://github.com/marketplacer/keychain-swift/wiki/Swift-1.2-setup).

## Usage

Add `import KeychainSwift` to your source code if you used Carthage or CocoaPods setup methods.

#### String values

```Swift
let keychain = KeychainSwift()

keychain.set("hello world", forKey: "my key")

keychain.get("my key")
```

#### Boolean values


```Swift
let keychain = KeychainSwift()

keychain.set(true, forKey: "my key")

keychain.getBool("my key")
```

#### NSData values

```Swift
let keychain = KeychainSwift()

keychain.set(nsDataObject, forKey: "my key")

keychain.getData("my key")
```

#### Removing keys from Keychain

```Swift
keychain.delete("my key") // Remove single key

keychain.clear() // Delete everything from app's Keychain
```

## Advanced options

### Keychain item access

Use `withAccess` parameter to specify the security level of the keychain storage.
By default the `.AccessibleWhenUnlocked` option is used. It is one of the most restrictive options and provides good data protection.

```
KeychainSwift().set("Hello world", forKey: "key 1", withAccess: .AccessibleWhenUnlocked)
```

You can use `.AccessibleAfterFirstUnlock` if you need your app to access the keychain item while in the background. Note that it is less secure than the `.AccessibleWhenUnlocked` option.

See the list of all available [access options](https://github.com/marketplacer/keychain-swift/blob/master/KeychainSwift/KeychainSwiftAccessOptions.swift).

### Sharing keychain items

In order to share keychain items between apps they need to have common *Keychain Groups* registered in *Capabilities > Keychain Sharing* settings. [This tutorial](http://evgenii.com/blog/sharing-keychain-in-ios/) shows how to set it up.

Use `accessGroup` property to access shared keychain items. In the following example we specify an access group "CS671JRA62.com.myapp.KeychainGroup" that will be used to set, get and delete an item "my key".

```Swift
let keychain = KeychainSwift()
keychain.accessGroup = "CS671JRA62.com.myapp.KeychainGroup" // Use your own access goup

keychain.set("hello world", forKey: "my key")
keychain.get("my key")
keychain.delete("my key")
keychain.clear()
```

*Note*: there is no way of sharing a keychain item between the watchOS 2.0 and its paired device: https://forums.developer.apple.com/thread/5938

### Setting key prefix

One can pass a `keyPrefix` argument when initializing a `KeychainSwift` object. The string passed in `keyPrefix` argument will be used as a prefix to **all the keys** used in `set`, `get`, `getData` and `delete` methods. I use the prefixed keychain in tests. This prevents the tests from changing the Keychain keys that are used when the app is launched manually.

Note that `clear` method still clears everything from the Keychain regardless of the prefix used.


```Swift
let keychain = KeychainSwift(keyPrefix: "myTestKey_")
keychain.set("hello world", forKey: "hello")
// Value will be stored under "myTestKey_hello" key
```

### Check if operation was successful

One can verify if `set`, `delete` and `clear` methods finished successfully by checking their return values. Those methods return `true` on success and `false` on error.

```Swift
if keychain.set("hello world", forKey: "my key") {
  // Keychain item is saved successfully
} else {
  // Report error
}
```

To get a specific failure reason use the `lastResultCode` property containing result code for the last operation. See [Keychain Services Result Codes](https://developer.apple.com/library/mac/documentation/Security/Reference/keychainservices/#//apple_ref/doc/uid/TP30000898-CH5g-CJBEABHG).

```Swift
keychain.set("hello world", forKey: "my key")
if keychain.lastResultCode != noErr { /* Report error */ }
```

## Demo app

<img src="https://raw.githubusercontent.com/marketplacer/keychain-swift/master/graphics/keychain-swift-demo.png" alt="Sacing and reading text from Keychaing in iOS and Swift" width="320">

## Alternative solutions

Here are some other Keychain libraries.

* [DanielTomlinson/Latch](https://github.com/DanielTomlinson/Latch)
* [jrendel/SwiftKeychainWrapper](https://github.com/jrendel/SwiftKeychainWrapper)
* [kishikawakatsumi/KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)
* [matthewpalmer/Locksmith](https://github.com/matthewpalmer/Locksmith)
* [phuonglm86/SwiftyKey](https://github.com/phuonglm86/SwiftyKey)
* [s-aska/KeyClip](https://github.com/s-aska/KeyClip)
* [yankodimitrov/SwiftKeychain](https://github.com/yankodimitrov/SwiftKeychain)

## Credits

* The code is based on this example: [https://gist.github.com/s-aska/e7ad24175fb7b04f78e7](https://gist.github.com/s-aska/e7ad24175fb7b04f78e7)
* Thanks to [glyuck](https://github.com/glyuck) for taming booleans.
* Thanks to [pepibumur](https://github.com/pepibumur) for adding OS X, watchOS and tvOS support.

## License

Keychain Swift is released under the [MIT License](LICENSE).
