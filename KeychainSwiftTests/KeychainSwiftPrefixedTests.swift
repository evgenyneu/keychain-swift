import XCTest

class KeychainWithPrefixTests: XCTestCase {
  
  var prefixed: KeychainSwift!
  var nonPrefixed: KeychainSwift!

  
  override func setUp() {
    super.setUp()
    
    prefixed = KeychainSwift(keyPrefix: "test_prefix_")
    nonPrefixed = KeychainSwift()
    
    prefixed.clear()
    nonPrefixed.clear()
    
    prefixed.lastQueryParameters = nil
  }
  
  func testKeyWithPrefix() {
    XCTAssertEqual("test_prefix_key", prefixed.keyWithPrefix("key"))
    XCTAssertEqual("key", nonPrefixed.keyWithPrefix("key"))
  }
  
  // MARK: - Set text
  // -----------------------
  
  func testSet() {
    let key = "key 1"
    XCTAssertTrue(prefixed.set("prefixed", forKey: key))
    XCTAssertTrue(nonPrefixed.set("non prefixed", forKey: key))
    
    XCTAssertEqual("prefixed", prefixed.get(key)!)
    XCTAssertEqual("non prefixed", nonPrefixed.get(key)!)
  }
  
  
  // MARK: - Set data
  // -----------------------
  
  func testSetData() {
    let key = "key 123"
    
    let dataPrefixed = "prefixed".data(using: String.Encoding.utf8)!
    let dataNonPrefixed = "non prefixed".data(using: String.Encoding.utf8)!
    
    XCTAssertTrue(prefixed.set(dataPrefixed, forKey: key))
    XCTAssertTrue(nonPrefixed.set(dataNonPrefixed, forKey: key))

    
    let dataFromKeychainPrefixed = prefixed.getData(key)!
    let textFromKeychainPrefixed = String(data: dataFromKeychainPrefixed, encoding: .utf8)!
    XCTAssertEqual("prefixed", textFromKeychainPrefixed)
    
    let dataFromKeychainNonPrefixed = nonPrefixed.getData(key)!
    let textFromKeychainNonPrefixed = String(data: dataFromKeychainNonPrefixed, encoding: .utf8)!
    XCTAssertEqual("non prefixed", textFromKeychainNonPrefixed)
  }
  
  // MARK: - Delete
  // -----------------------
  
  func testDelete() {
    let key = "key 1"
    XCTAssertTrue(prefixed.set("prefixed", forKey: key))
    XCTAssertTrue(nonPrefixed.set("non prefixed", forKey: key))
    
    prefixed.delete(key)
    
    XCTAssert(prefixed.get(key) == nil)
    XCTAssertFalse(nonPrefixed.get(key) == nil) // non-prefixed still exists
  }
  
}
