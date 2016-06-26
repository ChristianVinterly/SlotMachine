//
//  ArrayAllEqualTests.swift
//  SlotMachine
//
//  Created by Christian Lysne on 27/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import XCTest
@testable import SlotMachine

class ArrayAllEqualTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAllEqual() {
        let array = ["1", "1", "1"]
        let emptyArray: [String] = []
        
        XCTAssertTrue(array.allEqual())
        XCTAssertTrue(emptyArray.allEqual())
    }
}