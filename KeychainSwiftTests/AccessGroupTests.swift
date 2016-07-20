import XCTest

class AccessGroupTests: XCTestCase {
  
  var obj: KeychainSwift!
  
  override func setUp() {
    super.setUp()
    
    obj = KeychainSwift()
    obj.clear()
    obj.lastQueryParameters = nil
    obj.accessGroup = nil
  }
  
  // MARK: - Add access group
  
  func testAddAccessGroup() {
    let items: [String: NSObject] = [
      "one": "two"
    ]
    
    obj.accessGroup = "123.my.test.group"
    let result = obj.addAccessGroupWhenPresent(items)
    
    XCTAssertEqual(2, result.count)
    XCTAssertEqual("two", result["one"])
    XCTAssertEqual("123.my.test.group", result["agrp"])
  }
  
  func testAddAccessGroup_nil() {
    let items: [String: NSObject] = [
      "one": "two"
    ]
    
    let result = obj.addAccessGroupWhenPresent(items)
    
    XCTAssertEqual(1, result.count)
    XCTAssertEqual("two", result["one"])
  }
  
  func testSet() {
    obj.accessGroup = "123.my.test.group"
    obj.set("hello :)", forKey: "key 1")
    XCTAssertEqual("123.my.test.group", obj.lastQueryParameters?["agrp"])
  }
  
  func testGet() {
    obj.accessGroup = "123.my.test.group"
    _ = obj.get("key 1")
    XCTAssertEqual("123.my.test.group", obj.lastQueryParameters?["agrp"])
  }
  
  func testDelete() {
    obj.accessGroup = "123.my.test.group"
    obj.delete("key 1")
    XCTAssertEqual("123.my.test.group", obj.lastQueryParameters?["agrp"])
  }
  
  func testClear() {
    obj.accessGroup = "123.my.test.group"
    obj.clear()
    XCTAssertEqual("123.my.test.group", obj.lastQueryParameters?["agrp"])
  }
}
