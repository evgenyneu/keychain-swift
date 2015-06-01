import UIKit
import XCTest

class keychainTests: XCTestCase {
  override func setUp() {
    super.setUp()
    
    TegKeychain.clear()
    TegKeychain.lastQueryParameters = nil
  }

  // MARK: - Set text
  // -----------------------

  func testSet() {
    XCTAssertTrue(TegKeychain.set("hello :)", forKey: "key 1"))
    XCTAssertEqual("hello :)", TegKeychain.get("key 1")!)
  }
  
  func testSet_usesAccessibleWhenUnlockedByDefault() {
    XCTAssertTrue(TegKeychain.set("hello :)", forKey: "key 1"))
    
    let accessValue = TegKeychain.lastQueryParameters?[TegKeychainConstants.accessible] as? String
    XCTAssertEqual(TegKeychainAccessOptions.AccessibleWhenUnlocked.value, accessValue!)
  }
  
  func testSetWithAccessOption() {
    TegKeychain.set("hello :)", forKey: "key 1", withAccess: .AccessibleAfterFirstUnlock)
    let accessValue = TegKeychain.lastQueryParameters?[TegKeychainConstants.accessible] as? String
    XCTAssertEqual(TegKeychainAccessOptions.AccessibleAfterFirstUnlock.value, accessValue!)
  }
  
  // MARK: - Set data
  // -----------------------
  
  func testSetData() {
    let data = "hello world".dataUsingEncoding(NSUTF8StringEncoding)!
    
    XCTAssertTrue(TegKeychain.set(data, forKey: "key 123"))
    
    let dataFromKeychain = TegKeychain.getData("key 123")!
    let textFromKeychain = NSString(data: dataFromKeychain, encoding:NSUTF8StringEncoding) as! String
    XCTAssertEqual("hello world", textFromKeychain)
  }
  
  func testSetData_usesAccessibleWhenUnlockedByDefault() {
    let data = "hello world".dataUsingEncoding(NSUTF8StringEncoding)!
    
    TegKeychain.set(data, forKey: "key 123")
    
    let accessValue = TegKeychain.lastQueryParameters?[TegKeychainConstants.accessible] as? String
    XCTAssertEqual(TegKeychainAccessOptions.AccessibleWhenUnlocked.value, accessValue!)
  }

  // MARK: - Get
  // -----------------------

  func testGet_returnNilWhenValueNotSet() {
    XCTAssert(TegKeychain.get("key 1") == nil)
  }

  // MARK: - Delete
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

  // MARK: - Clear
  // -----------------------

  func testClear() {
    TegKeychain.set("hello :)", forKey: "key 1")
    TegKeychain.set("hello two", forKey: "key 2")
    
    TegKeychain.clear()
    
    XCTAssert(TegKeychain.get("key 1") == nil)
    XCTAssert(TegKeychain.get("key 2") == nil)
  }
}
