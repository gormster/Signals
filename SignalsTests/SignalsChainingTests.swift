//
//  SignalsChainingTests.swift
//  Signals
//
//  Created by Morgan Harris on 20/10/16.
//  Copyright © 2016 Tuomas Artman. All rights reserved.
//

import XCTest
import Signals
#if os(Linux)
import Dispatch
#endif

class SignalsChainingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasic() {
        let signal1 = Signal<String>()
        let signal2 = Signal<String>()
        let signal3 = Signal<String>()
        
        let referenceString = "This is a test"
        
        signal1.subscribe(source: signal2)
        signal2.subscribe(source: signal3)
        
        let expectation = self.expectation(description: "Signal comes through")
        signal1.subscribe(on: self) {
            XCTAssertEqual(referenceString, $0)
            expectation.fulfill()
        }
        
        signal3 => referenceString
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDelay() {
        let referenceString = "This is a test"
        
        func generateChain() -> Signal<String> {
            let signal1 = Signal<String>()
            let signal2 = Signal<String>()
            let signal3 = Signal<String>()
            
            signal1.subscribe(source: signal2)
            signal2.subscribe(source: signal3)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) { 
                signal3 => referenceString
            }
            
            return signal1
        }
        
        let signal = generateChain()
        let expectation = self.expectation(description: "Signal comes through")
        
        signal.subscribe(on:self) {
            XCTAssertEqual(referenceString, $0)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    class WeakSignals {
        var signal1: Signal<String>? = Signal<String>()
        weak var signal2: Signal<String>?
        weak var signal3: Signal<String>?
        
        init() {
            let signal2 = Signal<String>()
            let signal3 = Signal<String>()
            signal1!.subscribe(source: signal2)
            signal2.subscribe(source: signal3)
            
            self.signal2 = signal2
            self.signal3 = signal3
        }
    }
    
    func testPersistence() {
        
        let weaks = WeakSignals()
        
        XCTAssertNotNil(weaks.signal3)
        
        // The signal is the only owner of its descendant sources
        weaks.signal1 = nil
        
        XCTAssertNil(weaks.signal3)
        
    }
    
    func testBreakChain() {
        
        let weaks = WeakSignals()
        
        let referenceString = "This is a test"
        
        let ex = self.expectation(description: "Get fire")
        weaks.signal1?.subscribeOnce(on: self) {
            XCTAssertEqual(referenceString, $0)
            ex.fulfill()
        }
        weaks.signal3?.fire(referenceString)
        
        self.waitForExpectations(timeout: 1, handler: nil)
        
        // break the chain
        // hold a reference to signal 3 so it doesn't get deallocated
        
        let signal3 = weaks.signal3!
        
        weaks.signal1?.subscribeOnce(on: self) { _ in
            XCTFail("This should not have been fired")
        }
        
        weaks.signal2?.subscribeOnce(on: self) { _ in
            XCTFail("This should not have been fired")
        }
        
        weaks.signal1 = nil
        
        signal3.fire(referenceString)
        
        XCTAssertEqual(signal3.observers.count, 0)
        
    }
    
}
