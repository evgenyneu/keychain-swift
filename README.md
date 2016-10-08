# Helper functions for storing text in Keychain for iOS, macOS, tvOS and WatchOS

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/KeychainSwift.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/KeychainSwift.svg?style=flat)][cocoadocs]
[![Platform](https://img.shields.io/cocoapods/p/KeychainSwift.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/KeychainSwift
[carthage]: https://github.com/Carthage/Carthage

**⚠️ Xcode 8 warning ⚠️**: Keychain currently does not work on iOS 10 / Xcode 8 unless *Keychain Sharing* is enabled in *Capabilities* tab. See this [stackoverflow answer](http://stackoverflow.com/a/38543243/297131) for details.

This is a collection of helper functions for saving text and data in the Keychain.
 As you probably noticed Apple's keychain API is a bit verbose. This library was designed to provide shorter syntax for accomplishing a simple task: reading/writing text values for specified keys:

 ```Swift
let keychain = KeychainSwift()
keychain.set("hello world", forKey: "my key")
keychain.get("my key")
 ```

 The Keychain library includes the following features:

 * <a href="#usage">Get, set and delete string, boolean and Data Keychain items</a>
 * <a href="#keychain_item_access">Specify item access security level</a>
 * <a href="#keychain_synchronization">Synchronize items through iCloud</a>
 * <a href="#keychain_access_groups">Share Keychain items with other apps</a>

## What's Keychain?

Keychain is a secure storage. You can store all kind of sensitive data in it: user passwords, credit card numbers, secret tokens etc. Once stored in Keychain this information is only available to your app, other apps can't see it. Besides that, operating system makes sure this information is kept and processed securely. For example, text stored in Keychain can not be extracted from iPhone backup or from its file system. Apple recommends storing only small amount of data in the Keychain. If you need to secure something big you can encrypt it manually, save to a file and store the key in the Keychain.


## Setup (Swift 3.0)

There are three ways you can add KeychainSwift to your Xcode project.

#### Add source (iOS 7+)

Simply add [KeychainSwiftDistrib.swift](https://github.com/marketplacer/keychain-swift/blob/master/Distrib/KeychainSwiftDistrib.swift) file into your Xcode project.

#### Setup with Carthage (iOS 8+)

Alternatively, add `github "marketplacer/keychain-swift" ~> 7.0` to your Cartfile and run `carthage update`.

#### Setup with CocoaPods (iOS 8+)

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    target 'Your target name'
    pod 'KeychainSwift', '~> 7.0'


#### Setup with Swift Package Manager

Add the following text to your Package.swift file and run `swift build`.

```Swift
import PackageDescription

let package = Package(
    name: "KeychainSwift",
    dependencies: [
        .Package(url: "https://github.com/marketplacer/keychain-swift.git",
                 versions: Version(7,0,0)..<Version(8,0,0))
    ]
)
```


## Legacy Swift versions

Setup a [previous version](https://github.com/marketplacer/keychain-swift/wiki/Legacy-Swift-versions) of the library if you use an older version of Swift.


**iOS 7 support**

Use [iOS 7 compatible](https://github.com/marketplacer/keychain-swift/blob/iOS7/Distrib/KeychainSwiftDistrib.swift) version of the library.

<h2 id="usage">Usage</h2>

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

#### Data values

```Swift
let keychain = KeychainSwift()
keychain.set(dataObject, forKey: "my key")
keychain.getData("my key")
```

#### Removing keys from Keychain

```Swift
keychain.delete("my key") // Remove single key
keychain.clear() // Delete everything from app's Keychain. Does not work on macOS.
```

## Advanced options


<h3 id="keychain_item_access">Keychain item access</h3>

Use `withAccess` parameter to specify the security level of the keychain storage.
By default the `.accessibleWhenUnlocked` option is used. It is one of the most restrictive options and provides good data protection.

```
KeychainSwift().set("Hello world", forKey: "key 1", withAccess: .accessibleWhenUnlocked)
```

You can use `.accessibleAfterFirstUnlock` if you need your app to access the keychain item while in the background. Note that it is less secure than the `.accessibleWhenUnlocked` option.

See the list of all available [access options](https://github.com/marketplacer/keychain-swift/blob/master/KeychainSwift/KeychainSwiftAccessOptions.swift).


<h3 id="keychain_synchronization">Synchronizing keychain items with other devices</h3>

Set `synchronizable` property to `true` to enable keychain items synchronization across user's multiple devices. The synchronization will work for users who have the "Keychain" enabled in the iCloud settings on their devices.

Setting `synchronizable` property to `true` will add the item to other devices with the `set` method and obtain synchronizable items with the `get` command. Deleting a synchronizable item will remove it from all devices.

Note that you do NOT need to enable iCloud or Keychain Sharing capabilities in your app's target for this feature to work.


```Swift
// First device
let keychain = KeychainSwift()
keychain.synchronizable = true
keychain.set("hello world", forKey: "my key")

// Second device
let keychain = KeychainSwift()
keychain.synchronizable = true
keychain.get("my key") // Returns "hello world"
```

We could not get the Keychain synchronization work on macOS.


<h3 id="keychain_access_groups">Sharing keychain items with other apps</h3>

In order to share keychain items between apps on the same device they need to have common *Keychain Groups* registered in *Capabilities > Keychain Sharing* settings. [This tutorial](http://evgenii.com/blog/sharing-keychain-in-ios/) shows how to set it up.

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

One can pass a `keyPrefix` argument when initializing a `KeychainSwift` object. The string passed in `keyPrefix` argument will be used as a prefix to **all the keys** used in `set`, `get`, `getData` and `delete` methods. Adding a prefix to the keychain keys can be useful in unit tests. This prevents the tests from changing the Keychain keys that are used when the app is launched manually.

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

## Known serious issue

It [has been reported](https://github.com/marketplacer/keychain-swift/issues/15) that the library sometimes returns `nil`  instead of the stored Keychain value. The issue seems to be random and hard to reproduce. It may be connected with [the Keychain issue](https://forums.developer.apple.com/thread/4743) reported on Apple developer forums. If you experienced this problem feel free to create an issue so we can discuss it and find solutions.

## Demo app

<img src="https://raw.githubusercontent.com/marketplacer/keychain-swift/master/graphics/keychain-swift-demo-3.png" alt="Keychain Swift demo app" width="320">

## Running Keychain unit tests

Xcode 8 introduced additional hoops that one needs to jump through in order to run the unit test:

1. Enable signing in both the demo app and the test target.
1. Enable *Keychain Sharing* in the *Capabilities* tab of the demo app target.
1. Select the demo app as *Host Application* in the test target.

The process is shown in more details in [this article](http://evgenii.com/blog/testing-a-keychain-library-in-xcode/).

## Alternative solutions

Here are some other Keychain libraries.

* [DanielTomlinson/Latch](https://github.com/DanielTomlinson/Latch)
* [jrendel/SwiftKeychainWrapper](https://github.com/jrendel/SwiftKeychainWrapper)
* [kishikawakatsumi/KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)
* [matthewpalmer/Locksmith](https://github.com/matthewpalmer/Locksmith)
* [phuonglm86/SwiftyKey](https://github.com/phuonglm86/SwiftyKey)
* [s-aska/KeyClip](https://github.com/s-aska/KeyClip)
* [yankodimitrov/SwiftKeychain](https://github.com/yankodimitrov/SwiftKeychain)

## Thanks 👍

* The code is based on this example: [https://gist.github.com/s-aska/e7ad24175fb7b04f78e7](https://gist.github.com/s-aska/e7ad24175fb7b04f78e7)
* Thanks to [diogoguimaraes](https://github.com/diogoguimaraes) for adding Swift Package Manager setup option.
* Thanks to [glyuck](https://github.com/glyuck) for taming booleans.
* Thanks to [pepibumur](https://github.com/pepibumur) for adding macOS, watchOS and tvOS support.
* Thanks to [ezura](https://github.com/ezura) for iOS 7 support.
* Thanks to [mikaoj](https://github.com/mikaoj) for adding keychain synchronization.
* Thanks to [tcirwin](https://github.com/tcirwin) for adding Swift 3.0 support.
* Thanks to [Tulleb](https://github.com/Tulleb) for adding Xcode 8 beta 6 support.


## License

Keychain Swift is released under the [MIT License](LICENSE).
