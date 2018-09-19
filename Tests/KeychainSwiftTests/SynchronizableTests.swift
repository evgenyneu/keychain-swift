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
    let items: [String: Any] = [
      "one": "two"
    ]
    
    obj.synchronizable = true
    let result = obj.addSynchronizableIfRequired(items, addingItems: false)
    
    XCTAssertEqual(2, result.count)
    XCTAssertEqual("two", result["one"] as! String)
    XCTAssertEqual(kSecAttrSynchronizableAny as String, result["sync"] as! String)
  }
  
  func testAddSynchronizableGroup_addItemsTrue() {
    let items: [String: Any] = [
      "one": "two"
    ]
    
    obj.synchronizable = true
    let result = obj.addSynchronizableIfRequired(items, addingItems: true)
    
    XCTAssertEqual(2, result.count)
    XCTAssertEqual("two", result["one"] as! String)
    XCTAssertEqual(true, result["sync"] as! Bool)
  }
  
  func testAddSynchronizableGroup_nil() {
    let items: [String: Any] = [
      "one": "two"
    ]
    
    let result = obj.addSynchronizableIfRequired(items, addingItems: false)
    
    XCTAssertEqual(1, result.count)
    XCTAssertEqual("two", result["one"] as! String)
  }
  
  // MARK: - Set
  
  func testSet() {
    obj.synchronizable = true
    obj.set("hello :)", forKey: "key 1")
    XCTAssertEqual(true, obj.lastQueryParameters?["sync"] as! Bool)
  }
  
  func testSet_doNotSetSynchronizable() {
    obj.set("hello :)", forKey: "key 1")
    XCTAssertNil(obj.lastQueryParameters?["sync"])
  }
  
  // MARK: - Get
  
  func testGet() {
    obj.synchronizable = true
    _ = obj.get("key 1")
    XCTAssertEqual(kSecAttrSynchronizableAny as String, obj.lastQueryParameters?["sync"] as! String)
  }
  
  func testGet_doNotSetSynchronizable() {
    _ = obj.get("key 1")
    XCTAssertNil(obj.lastQueryParameters?["sync"])
  }
  
  // MARK: - Delete

  func testDelete() {
    obj.synchronizable = true
    obj.delete("key 1")
    XCTAssertEqual(kSecAttrSynchronizableAny as String, obj.lastQueryParameters?["sync"] as! String)
  }
  
  func testDelete_doNotSetSynchronizable() {
    obj.delete("key 1")
    XCTAssertNil(obj.lastQueryParameters?["sync"])
  }
  
  // MARK: - Clear
  
  func testClear() {
    obj.synchronizable = true
    obj.clear()
    XCTAssertEqual(kSecAttrSynchronizableAny as String, obj.lastQueryParameters?["sync"] as! String)
  }
  
  func testClear_doNotSetSynchronizable() {
    obj.clear()
    XCTAssertNil(obj.lastQueryParameters?["sync"])
  }
}
