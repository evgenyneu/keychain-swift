import UIKit
import XCTest

class SynchronizableTests: XCTestCase {
  
  var obj: KeychainSwift!
  
  override func setUp() {
    super.setUp()
    
    obj = KeychainSwift()
    obj.clear()
    obj.lastQueryParameters = nil
    obj.synchronizable = false
  }
  
  // MARK: - addSynchronizableIfRequired
  
  func testAddSynchronizableGroup_addItemsFalse() {
    let items: [String: NSObject] = [
      "one": "two"
    ]
    
    obj.synchronizable = true
    let result = obj.addSynchronizableIfRequired(items, addingItems: false)
    
    XCTAssertEqual(2, result.count)
    XCTAssertEqual("two", result["one"])
    XCTAssertEqual(kSecAttrSynchronizableAny, result["sync"])
  }
  
  func testAddSynchronizableGroup_addItemsTrue() {
    let items: [String: NSObject] = [
      "one": "two"
    ]
    
    obj.synchronizable = true
    let result = obj.addSynchronizableIfRequired(items, addingItems: true)
    
    XCTAssertEqual(2, result.count)
    XCTAssertEqual("two", result["one"])
    XCTAssertEqual(true, result["sync"])
  }
  
  func testAddSynchronizableGroup_nil() {
    let items: [String: NSObject] = [
      "one": "two"
    ]
    
    let result = obj.addSynchronizableIfRequired(items, addingItems: false)
    
    XCTAssertEqual(1, result.count)
    XCTAssertEqual("two", result["one"])
  }
  
  // MARK: - Set
  
  func testSet() {
    obj.synchronizable = true
    obj.set("hello :)", forKey: "key 1")
    XCTAssertEqual(true, obj.lastQueryParameters?["sync"])
  }
  
  func testSet_doNotSetSynchronizable() {
    obj.set("hello :)", forKey: "key 1")
    XCTAssertNil(obj.lastQueryParameters?["sync"])
  }
  
  // MARK: - Get
  
  func testGet() {
    obj.synchronizable = true
    obj.get("key 1")
    XCTAssertEqual(kSecAttrSynchronizableAny, obj.lastQueryParameters?["sync"])
  }
  
  func testGet_doNotSetSynchronizable() {
    obj.get("key 1")
    XCTAssertNil(obj.lastQueryParameters?["sync"])
  }
  
  // MARK: - Delete

  func testDelete() {
    obj.synchronizable = true
    obj.delete("key 1")
    XCTAssertEqual(kSecAttrSynchronizableAny, obj.lastQueryParameters?["sync"])
  }
  
  func testDelete_doNotSetSynchronizable() {
    obj.delete("key 1")
    XCTAssertNil(obj.lastQueryParameters?["sync"])
  }
  
  // MARK: - Clear
  
  func testClear() {
    obj.synchronizable = true
    obj.clear()
    XCTAssertEqual(kSecAttrSynchronizableAny, obj.lastQueryParameters?["sync"])
  }
  
  func testClear_doNotSetSynchronizable() {
    obj.clear()
    XCTAssertNil(obj.lastQueryParameters?["sync"])
  }
}