//
//  SlotMachineViewModelTests.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import XCTest
@testable import SlotMachine

class SlotMachineViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSlotMachineInitialization() {
        
        let fruitImageName = getFruitImageName()
        let slotElement = SlotElement(imageName: fruitImageName)
        let slotColumn = SlotColumn(slotElements: [slotElement], numberOfSlotElementsOnScreen: 3)
        let slotMachine = SlotMachine(slotColumns: [slotColumn])
        
        let slotMachineViewModel = SlotMachineViewModel(slotMachine: slotMachine)
        
        XCTAssertNotNil(slotMachineViewModel)
        XCTAssertTrue(slotMachineViewModel.slotMachine == slotMachine)
    }
    
    func testSlotColumnViewModels() {
        let fruitImageName = getFruitImageName()
        let slotElement = SlotElement(imageName: fruitImageName)
        let slotColumn = SlotColumn(slotElements: [slotElement], numberOfSlotElementsOnScreen: 3)
        let slotMachine = SlotMachine(slotColumns: [slotColumn])
        
        let slotMachineViewModel = SlotMachineViewModel(slotMachine: slotMachine)
        let expectedViewModel = SlotColumnViewModel(slotColumn: slotColumn)
        
        XCTAssertTrue(slotMachineViewModel.slotColumnViewModels().first! == expectedViewModel)
    }
}