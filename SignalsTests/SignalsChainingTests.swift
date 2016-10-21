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
    
}
