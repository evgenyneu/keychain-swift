import XCTest

class KeychainSwiftTests: XCTestCase {
  
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
    XCTAssertEqual(KeychainSwiftAccessOptions.accessibleWhenUnlocked.value, accessValue!)
  }
  
  func testSetWithAccessOption() {
    obj.set("hello :)", forKey: "key 1", withAccess: .accessibleAfterFirstUnlock)
    let accessValue = obj.lastQueryParameters?[KeychainSwiftConstants.accessible] as? String
    XCTAssertEqual(KeychainSwiftAccessOptions.accessibleAfterFirstUnlock.value, accessValue!)
  }
  
  // MARK: - Set data
  // -----------------------
  
  func testSetData() {
    let data = "hello world".data(using: String.Encoding.utf8)!
    
    XCTAssertTrue(obj.set(data, forKey: "key 123"))
    
    let dataFromKeychain = obj.getData("key 123")!
    let textFromKeychain = String(data: dataFromKeychain, encoding:String.Encoding.utf8)!
    XCTAssertEqual("hello world", textFromKeychain)
  }
  
  func testSetData_usesAccessibleWhenUnlockedByDefault() {
    let data = "hello world".data(using: String.Encoding.utf8)!
    
    obj.set(data, forKey: "key 123")
    
    let accessValue = obj.lastQueryParameters?[KeychainSwiftConstants.accessible] as? String
    XCTAssertEqual(KeychainSwiftAccessOptions.accessibleWhenUnlocked.value, accessValue!)
  }

  // MARK: - Set bool
  // -----------------------

  func testSetBool() {
    XCTAssertTrue(obj.set(true, forKey: "key bool"))
    XCTAssertTrue(obj.getBool("key bool")!)
    XCTAssertTrue(obj.set(false, forKey: "key bool"))
    XCTAssertFalse(obj.getBool("key bool")!)
  }

  func testSetBool_usesAccessibleWhenUnlockedByDefault() {
    XCTAssertTrue(obj.set(false, forKey: "key bool"))
    let accessValue = obj.lastQueryParameters?[KeychainSwiftConstants.accessible] as? String
    XCTAssertEqual(KeychainSwiftAccessOptions.accessibleWhenUnlocked.value, accessValue!)
  }

  // MARK: - Get
  // -----------------------

  func testGet_returnNilWhenValueNotSet() {
    XCTAssert(obj.get("key 1") == nil)
  }

  // MARK: - Get bool
  // -----------------------

  func testGetBool_returnNilWhenValueNotSet() {
    XCTAssert(obj.getBool("some bool key") == nil)
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
}
