//
//  ConcurrencyTests.swift
//  KeychainSwift
//
//  Created by Eli Kohen on 08/02/2017.
//  Copyright © 2017 Marketplacer. All rights reserved.
//

import XCTest

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

        for _ in 0..<1000 {
            self.obj.set(dataToWrite, forKey: "test-key")
            let _ = self.obj.get("test-key")
        }
        self.waitForExpectations(timeout: 20, handler: nil)

        XCTAssertEqual(500, writes)
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
