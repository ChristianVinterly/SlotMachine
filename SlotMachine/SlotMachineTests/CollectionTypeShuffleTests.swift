//
//  CollectionType+ShuffleTests.swift
//  SlotMachine
//
//  Created by Christian Lysne on 27/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import XCTest
@testable import SlotMachine

class CollectionTypeShuffleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShuffle() {
        let array = ["1", "2", "3"]
        let shuffledArray = array.shuffle()
        
        XCTAssertTrue(array != shuffledArray)
    }
    
    func testShuffleArrayWithOneElement() {
        let array = ["1"]
        let shuffledArray = array.shuffle()
        
        XCTAssertTrue(array == shuffledArray)
    }
}