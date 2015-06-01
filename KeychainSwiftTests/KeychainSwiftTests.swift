import UIKit
import XCTest

class keychainTests: XCTestCase {
  override func setUp() {
    super.setUp()
    
    KeychainSwift.clear()
    KeychainSwift.lastQueryParameters = nil
  }

  // MARK: - Set text
  // -----------------------

  func testSet() {
    XCTAssertTrue(KeychainSwift.set("hello :)", forKey: "key 1"))
    XCTAssertEqual("hello :)", KeychainSwift.get("key 1")!)
  }
  
  func testSet_usesAccessibleWhenUnlockedByDefault() {
    XCTAssertTrue(KeychainSwift.set("hello :)", forKey: "key 1"))
    
    let accessValue = KeychainSwift.lastQueryParameters?[KeychainSwiftConstants.accessible] as? String
    XCTAssertEqual(KeychainSwiftAccessOptions.AccessibleWhenUnlocked.value, accessValue!)
  }
  
  func testSetWithAccessOption() {
    KeychainSwift.set("hello :)", forKey: "key 1", withAccess: .AccessibleAfterFirstUnlock)
    let accessValue = KeychainSwift.lastQueryParameters?[KeychainSwiftConstants.accessible] as? String
    XCTAssertEqual(KeychainSwiftAccessOptions.AccessibleAfterFirstUnlock.value, accessValue!)
  }
  
  // MARK: - Set data
  // -----------------------
  
  func testSetData() {
    let data = "hello world".dataUsingEncoding(NSUTF8StringEncoding)!
    
    XCTAssertTrue(KeychainSwift.set(data, forKey: "key 123"))
    
    let dataFromKeychain = KeychainSwift.getData("key 123")!
    let textFromKeychain = NSString(data: dataFromKeychain, encoding:NSUTF8StringEncoding) as! String
    XCTAssertEqual("hello world", textFromKeychain)
  }
  
  func testSetData_usesAccessibleWhenUnlockedByDefault() {
    let data = "hello world".dataUsingEncoding(NSUTF8StringEncoding)!
    
    KeychainSwift.set(data, forKey: "key 123")
    
    let accessValue = KeychainSwift.lastQueryParameters?[KeychainSwiftConstants.accessible] as? String
    XCTAssertEqual(KeychainSwiftAccessOptions.AccessibleWhenUnlocked.value, accessValue!)
  }

  // MARK: - Get
  // -----------------------

  func testGet_returnNilWhenValueNotSet() {
    XCTAssert(KeychainSwift.get("key 1") == nil)
  }

  // MARK: - Delete
  // -----------------------

  func testDelete() {
    KeychainSwift.set("hello :)", forKey: "key 1")
    KeychainSwift.delete("key 1")
    
    XCTAssert(KeychainSwift.get("key 1") == nil)
  }

  func testDelete_deleteOnSingleKey() {
    KeychainSwift.set("hello :)", forKey: "key 1")
    KeychainSwift.set("hello two", forKey: "key 2")

    KeychainSwift.delete("key 1")
    
    XCTAssertEqual("hello two", KeychainSwift.get("key 2")!)
  }

  // MARK: - Clear
  // -----------------------

  func testClear() {
    KeychainSwift.set("hello :)", forKey: "key 1")
    KeychainSwift.set("hello two", forKey: "key 2")
    
    KeychainSwift.clear()
    
    XCTAssert(KeychainSwift.get("key 1") == nil)
    XCTAssert(KeychainSwift.get("key 2") == nil)
  }
}
