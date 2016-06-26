//
//  SpinButtonTests.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import XCTest
@testable import SlotMachine

class SpinButtonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitializeSpinButton() {
        let spinButton = SpinButton(frame: CGRectZero)
        XCTAssertNotNil(spinButton)
    }
    
    func testInitializeSpinButtonWithDecoder() {
        let coder = NSKeyedUnarchiver(forReadingWithData: NSMutableData())
        let spinButton = SpinButton(coder: coder)
        XCTAssertNotNil(spinButton)
    }
    
    func testSpinningState() {
        let spinButton = SpinButton(frame: CGRectZero)
        
        XCTAssertTrue(spinButton.buttonState == .ReadyToSpin)
        XCTAssertTrue(spinButton.enabled)
        
        spinButton.buttonState = .Spinning
        
        XCTAssertTrue(spinButton.buttonState == .Spinning)
        XCTAssertFalse(spinButton.enabled)
    }
}