//
//  ConcurrencyTests.swift
//  KeychainSwift
//
//  Created by Eli Kohen on 08/02/2017.
//

import XCTest
@testable import KeychainSwift

class ConcurrencyTests: XCTestCase {

    var obj: KeychainSwift!

    override func setUp() {
        super.setUp()

        obj = KeychainSwift()
        obj.clear()
        obj.lastQueryParameters = nil
        obj.synchronizable = false
    }

    // MARK: - addSynchronizableIfRequired

    func testConcurrencyDoesntCrash() {

        let expectation = self.expectation(description: "Wait for write loop")
        let expectation2 = self.expectation(description: "Wait for write loop")


        let dataToWrite = "{ asdf ñlk BNALSKDJFÑLAKSJDFÑLKJ ZÑCLXKJ ÑALSKDFJÑLKASJDFÑLKJASDÑFLKJAÑSDLKFJÑLKJ}"
        obj.set(dataToWrite, forKey: "test-key")

        var writes = 0

        let readQueue = DispatchQueue(label: "ReadQueue", attributes: [])
        readQueue.async {
            for _ in 0..<400 {
                let _: String? = synchronize( { completion in
                    let result: String? = self.obj.get("test-key")
                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                            completion(result)
                        }
                    }
                }, timeoutWith: nil)
            }
        }
        let readQueue2 = DispatchQueue(label: "ReadQueue2", attributes: [])
        readQueue2.async {
            for _ in 0..<400 {
                let _: String? = synchronize( { completion in
                    let result: String? = self.obj.get("test-key")
                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                            completion(result)
                        }
                    }
                }, timeoutWith: nil)
            }
        }
        let readQueue3 = DispatchQueue(label: "ReadQueue3", attributes: [])
        readQueue3.async {
            for _ in 0..<400 {
                let _: String? = synchronize( { completion in
                    let result: String? = self.obj.get("test-key")
                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                            completion(result)
                        }
                    }
                }, timeoutWith: nil)
            }
        }
      
        let deleteQueue = DispatchQueue(label: "deleteQueue", attributes: [])
        deleteQueue.async {
          for _ in 0..<400 {
            let _: Bool = synchronize( { completion in
              let result = self.obj.delete("test-key")
              DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                  completion(result)
                }
              }
            }, timeoutWith: false)
          }
        }
      
        let deleteQueue2 = DispatchQueue(label: "deleteQueue2", attributes: [])
        deleteQueue2.async {
          for _ in 0..<400 {
            let _: Bool = synchronize( { completion in
              let result = self.obj.delete("test-key")
              DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                  completion(result)
                }
              }
            }, timeoutWith: false)
          }
        }
      
        let clearQueue = DispatchQueue(label: "clearQueue", attributes: [])
        clearQueue.async {
          for _ in 0..<400 {
            let _: Bool = synchronize( { completion in
              let result = self.obj.clear()
              DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                  completion(result)
                }
              }
            }, timeoutWith: false)
          }
        }
      
        let clearQueue2 = DispatchQueue(label: "clearQueue2", attributes: [])
        clearQueue2.async {
          for _ in 0..<400 {
            let _: Bool = synchronize( { completion in
              let result = self.obj.clear()
              DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                  completion(result)
                }
              }
            }, timeoutWith: false)
          }
        }

        let writeQueue = DispatchQueue(label: "WriteQueue", attributes: [])
        writeQueue.async {
            for _ in 0..<500 {
                let written: Bool = synchronize({ completion in
                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                            let result = self.obj.set(dataToWrite, forKey: "test-key")
                            completion(result)
                        }
                    }
                }, timeoutWith: false)
                if written {
                    writes = writes + 1
                }
            }
            expectation.fulfill()
        }
      
        let writeQueue2 = DispatchQueue(label: "WriteQueue2", attributes: [])
        writeQueue2.async {
          for _ in 0..<500 {
            let written: Bool = synchronize({ completion in
              DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                  let result = self.obj.set(dataToWrite, forKey: "test-key")
                  completion(result)
                }
              }
            }, timeoutWith: false)
            if written {
              writes = writes + 1
            }
          }
          expectation2.fulfill()
        }

        for _ in 0..<1000 {
            self.obj.set(dataToWrite, forKey: "test-key")
            let _ = self.obj.get("test-key")
        }
        self.waitForExpectations(timeout: 30, handler: nil)

        XCTAssertEqual(1000, writes)
    }
}


// Synchronizes a asynch closure
// Ref: https://forums.developer.apple.com/thread/11519
func synchronize<ResultType>(_ asynchClosure: (_ completion: @escaping (ResultType) -> ()) -> Void,
                        timeout: DispatchTime = DispatchTime.distantFuture, timeoutWith: @autoclosure @escaping () -> ResultType) -> ResultType {
    let sem = DispatchSemaphore(value: 0)

    var result: ResultType?

    asynchClosure { (r: ResultType) -> () in
        result = r
        sem.signal()
    }
    _ = sem.wait(timeout: timeout)
    if result == nil {
        result = timeoutWith()
    }
    return result!
}
