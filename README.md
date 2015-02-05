# iOS/Swift library for storing data in Keychain

A helper class that provides a simple way of writing to and reading from a Keychain.
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

### Reference

The code is based on this gist:

[https://gist.github.com/s-aska/e7ad24175fb7b04f78e7](https://gist.github.com/s-aska/e7ad24175fb7b04f78e7)