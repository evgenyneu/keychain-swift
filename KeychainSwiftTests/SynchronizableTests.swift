import UIKit
import XCTest

class SynchronizableTests: XCTestCase {
  
  var obj: KeychainSwift!
  
  override func setUp() {
    super.setUp()
    
    obj = KeychainSwift()
    obj.clear()
    obj.lastQueryParameters = nil
    obj.synchronizable = true
  }
  
  // MARK: - Add access group
  
  func testAddAccessGroup() {
    let items: [String: NSObject] = [
      "one": "two"
    ]
    
    obj.synchronizable = true
    let result = obj.addSynchronizableIfRequired(items)
    
    XCTAssertEqual(2, result.count)
    XCTAssertEqual("two", result["one"])
    XCTAssertEqual(kSecAttrSynchronizableAny, result["sync"])
  }
}