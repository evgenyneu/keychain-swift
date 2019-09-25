import XCTest
@testable import KeychainSwift

class ClearTests: XCTestCase {
  
  var obj: KeychainSwift!
  
  override func setUp() {
    super.setUp()
    
    obj = KeychainSwift()
  }
  
  func testClear() {
    obj.set("hello :)", forKey: "key 1")
    obj.set("hello two", forKey: "key 2")
    
    obj.clear()
    
    XCTAssert(obj.get("key 1") == nil)
    XCTAssert(obj.get("key 2") == nil)
  }
}

