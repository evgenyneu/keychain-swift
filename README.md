# iOS/Swift helper functions for storing data in Keychain

This is a collection of helper functions for writing/reading text from a Keychain.

As you probably noticed Apple's keychain API is a bit verbose.
This class was designed to provide shorter syntax for accomplishing a simple task: reading/writing text values for specified keys.

The project also includes a demo app.

## Installation

Copy `TegKeychain.swift` into your project.

## Usage

```Swift
TegKeychain.set("my key", value: "hello world")

TegKeychain.getString("key 1")

TegKeychain.delete("my key")

TegKeychain.clear()
```

In addition to String one cart write and read `NSData` objects.

```Swift
TegKeychain.set("my key", value: nsDataObject)

TegKeychain.getData("my key")
```


## Demo app

<img src="https://raw.githubusercontent.com/exchangegroup/keychain-swift/master/graphics/keychain-swift-demo.png" alt="Sacing and reading text from Keychaing in iOS and Swift">

### Reference

The code is based on this gist:

[https://gist.github.com/s-aska/e7ad24175fb7b04f78e7](https://gist.github.com/s-aska/e7ad24175fb7b04f78e7)