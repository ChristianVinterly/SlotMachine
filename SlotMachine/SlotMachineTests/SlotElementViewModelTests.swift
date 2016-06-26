//
//  SlotMachineTests.swift
//  SlotMachineTests
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import XCTest
@testable import SlotMachine

class SlotElementViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: Initialization Tests
    func testSlotElementInitialization() {
        
        let fruitImageName = getFruitImageName()
        let slotElement = SlotElement(imageName: fruitImageName)
        
        let slotElementViewModel = SlotElementViewModel(slotElement: slotElement)
        
        XCTAssertNotNil(slotElementViewModel)
        XCTAssertTrue(slotElementViewModel.slotElement == slotElement)
    }
}
