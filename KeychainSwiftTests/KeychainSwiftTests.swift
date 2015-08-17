import UIKit
import XCTest

class keychainTests: XCTestCase {
  
  var obj: KeychainSwift!
  
  override func setUp() {
    super.setUp()
    
    obj = KeychainSwift()
    obj.clear()
    obj.lastQueryParameters = nil
  }

  // MARK: - Set text
  // -----------------------

  func testSet() {
    XCTAssertTrue(obj.set("hello :)", forKey: "key 1"))
    XCTAssertEqual("hello :)", obj.get("key 1")!)
  }
  
  func testSet_usesAccessibleWhenUnlockedByDefault() {
    XCTAssertTrue(obj.set("hello :)", forKey: "key 1"))
    
    let accessValue = obj.lastQueryParameters?[KeychainSwiftConstants.accessible] as? String
    XCTAssertEqual(KeychainSwiftAccessOptions.AccessibleWhenUnlocked.value, accessValue!)
  }
  
  func testSetWithAccessOption() {
    obj.set("hello :)", forKey: "key 1", withAccess: .AccessibleAfterFirstUnlock)
    let accessValue = obj.lastQueryParameters?[KeychainSwiftConstants.accessible] as? String
    XCTAssertEqual(KeychainSwiftAccessOptions.AccessibleAfterFirstUnlock.value, accessValue!)
  }
  
  // MARK: - Set data
  // -----------------------
  
  func testSetData() {
    let data = "hello world".dataUsingEncoding(NSUTF8StringEncoding)!
    
    XCTAssertTrue(obj.set(data, forKey: "key 123"))
    
    let dataFromKeychain = obj.getData("key 123")!
    let textFromKeychain = NSString(data: dataFromKeychain, encoding:NSUTF8StringEncoding) as! String
    XCTAssertEqual("hello world", textFromKeychain)
  }
  
  func testSetData_usesAccessibleWhenUnlockedByDefault() {
    let data = "hello world".dataUsingEncoding(NSUTF8StringEncoding)!
    
    obj.set(data, forKey: "key 123")
    
    let accessValue = obj.lastQueryParameters?[KeychainSwiftConstants.accessible] as? String
    XCTAssertEqual(KeychainSwiftAccessOptions.AccessibleWhenUnlocked.value, accessValue!)
  }

  // MARK: - Get
  // -----------------------

  func testGet_returnNilWhenValueNotSet() {
    XCTAssert(obj.get("key 1") == nil)
  }

  // MARK: - Delete
  // -----------------------

  func testDelete() {
    obj.set("hello :)", forKey: "key 1")
    obj.delete("key 1")
    
    XCTAssert(obj.get("key 1") == nil)
  }

  func testDelete_deleteOnSingleKey() {
    obj.set("hello :)", forKey: "key 1")
    obj.set("hello two", forKey: "key 2")

    obj.delete("key 1")
    
    XCTAssertEqual("hello two", obj.get("key 2")!)
  }

  // MARK: - Clear
  // -----------------------

  func testClear() {
    obj.set("hello :)", forKey: "key 1")
    obj.set("hello two", forKey: "key 2")
    
    obj.clear()
    
    XCTAssert(obj.get("key 1") == nil)
    XCTAssert(obj.get("key 2") == nil)
  }
}
