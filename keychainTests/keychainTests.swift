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
    XCTAssertTrue(TegKeychain.set("key 1", value: "hello :)"))
    XCTAssertEqual("hello :)", TegKeychain.get("key 1")!)
  }

  // Get
  // -----------------------

  func testGet_returnNilWhenValueNotSet() {
    XCTAssert(TegKeychain.get("key 1") == nil)
  }

  // Delete
  // -----------------------

  func testDelete() {
    TegKeychain.set("key 1", value: "hello :)")
    TegKeychain.delete("key 1")
    
    XCTAssert(TegKeychain.get("key 1") == nil)
  }

  func testDelete_deleteOnSingleKey() {
    TegKeychain.set("key 1", value: "hello :)")
    TegKeychain.set("key 2", value: "hello two")

    TegKeychain.delete("key 1")
    
    XCTAssertEqual("hello two", TegKeychain.get("key 2")!)
  }

  // Clear
  // -----------------------

  func testClear() {
    TegKeychain.set("key 1", value: "hello :)")
    TegKeychain.set("key 2", value: "hello two")
    
    TegKeychain.clear()
    
    XCTAssert(TegKeychain.get("key 1") == nil)
    XCTAssert(TegKeychain.get("key 2") == nil)
  }
}
