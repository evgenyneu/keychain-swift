import UIKit
import XCTest
import keychain

class keychainTests: XCTestCase {
  override func setUp() {
    super.setUp()
    
    TegKeychain.clear()
  }

  // Set
  // -----------------------

  func testSet() {
    XCTAssertTrue(TegKeychain.set("hello :)", forKey: "key 1"))
    XCTAssertEqual("hello :)", TegKeychain.get("key 1")!)
  }
  
  func testSetWithAccessOption() {
    TegKeychain.set("hello :)", forKey: "key 1", withAccess: .AccessibleAfterFirstUnlock)
  }

  // Get
  // -----------------------

  func testGet_returnNilWhenValueNotSet() {
    XCTAssert(TegKeychain.get("key 1") == nil)
  }

  // Delete
  // -----------------------

  func testDelete() {
    TegKeychain.set("hello :)", forKey: "key 1")
    TegKeychain.delete("key 1")
    
    XCTAssert(TegKeychain.get("key 1") == nil)
  }

  func testDelete_deleteOnSingleKey() {
    TegKeychain.set("hello :)", forKey: "key 1")
    TegKeychain.set("hello two", forKey: "key 2")

    TegKeychain.delete("key 1")
    
    XCTAssertEqual("hello two", TegKeychain.get("key 2")!)
  }

  // Clear
  // -----------------------

  func testClear() {
    TegKeychain.set("hello :)", forKey: "key 1")
    TegKeychain.set("hello two", forKey: "key 2")
    
    TegKeychain.clear()
    
    XCTAssert(TegKeychain.get("key 1") == nil)
    XCTAssert(TegKeychain.get("key 2") == nil)
  }
}
