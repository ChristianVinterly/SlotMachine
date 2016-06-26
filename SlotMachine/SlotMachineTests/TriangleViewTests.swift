//
//  TriangleViewTests.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import XCTest
@testable import SlotMachine

class TriangleViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitializeTriangleView() {
        let triangleView = TriangleView(frame: CGRectZero)
        XCTAssertNotNil(triangleView)
    }
    
    func testInitializeTriangleViewWithDecoder() {
        let coder = NSKeyedUnarchiver(forReadingWithData: NSMutableData())
        let triangleView = TriangleView(coder: coder)
        XCTAssertNotNil(triangleView)
    }
}