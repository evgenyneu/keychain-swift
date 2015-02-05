# iOS/Swift helper functions for storing text in Keychain

This is a collection of helper functions for writing/reading text from a Keychain. As you probably noticed Apple's keychain API is a bit verbose. This class was designed to provide shorter syntax for accomplishing a simple task: reading/writing text values for specified keys.

## What's Keychain?

Keychain is a secure storage on iOS device. You can use these functions to store all kind of sensitive data in it: user passwords, credit card numbers, secret tokens etc. Once stored in a Keychain this information is only available to your app, other apps can't see it. Besides that iOS device makes sure this information is kept and processed securely. For example, text stored in Keychain can not be retried from iPhone backup or by examining its file system.

Tested in iOS 7 and 8.

## Installation

Copy [TegKeychain.swift](https://raw.githubusercontent.com/exchangegroup/keychain-swift/master/keychain/TegKeychain.swift) into your project.

## Usage

```Swift
TegKeychain.set("my key", value: "hello world")

TegKeychain.get("my key")

TegKeychain.delete("my key")

TegKeychain.clear() // delete everything from app's Keychain
```

In addition to strings one can set/get `NSData` objects.

```Swift
TegKeychain.set("my key", value: nsDataObject)

TegKeychain.getData("my key")
```

## Demo app

<img src="https://raw.githubusercontent.com/exchangegroup/keychain-swift/master/graphics/keychain-swift-demo.png" alt="Sacing and reading text from Keychaing in iOS and Swift" width="320">

### Reference

The code is based on this example: [https://gist.github.com/s-aska/e7ad24175fb7b04f78e7](https://gist.github.com/s-aska/e7ad24175fb7b04f78e7)

### Repository home

https://github.com/exchangegroup/keychain-swift
