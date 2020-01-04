//
//  AllKeysTests.swift
//  KeychainSwiftTests
//
//  Created by Lucas Paim on 02/01/20.
//  Copyright © 2020 Evgenii Neumerzhitckii. All rights reserved.
//

import XCTest
@testable import KeychainSwift


class AllKeysTests: XCTestCase {
  
  var obj: KeychainSwift!
  
  override func setUp() {
    super.setUp()
    
    obj = KeychainSwift()
    obj.clear()
  }
  
  // MARK: - allKeys
  func testAddSynchronizableGroup_addItemsFalse() {
    let items: [String] = [
      "one", "two"
    ]
    
    items.enumerated().forEach { enumerator in
        self.obj!.set("\(enumerator.offset)", forKey: enumerator.element)
    }
    
    XCTAssertEqual(["one", "two"], obj.allKeys)
    
    obj.clear()
    XCTAssertEqual(obj.allKeys, [])
    
  }
}
