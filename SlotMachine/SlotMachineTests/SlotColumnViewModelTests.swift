//
//  SlotColumnTests.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import XCTest
@testable import SlotMachine

class SlotColumnViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSlotColumnInitialization() {
        
        let fruitImageName = getFruitImageName()
        let slotElement = SlotElement(imageName: fruitImageName)
        let slotColumn = SlotColumn(slotElements: [slotElement], numberOfSlotElementsOnScreen: 3)
        
        let slotColumnViewModel = SlotColumnViewModel(slotColumn: slotColumn)
        
        XCTAssertNotNil(slotColumnViewModel)
        XCTAssertTrue(slotColumnViewModel.slotColumn == slotColumn)
    }
    
    func testImagesForColumn() {
        let fruitImageName = getFruitImageName()
        let slotElement = SlotElement(imageName: fruitImageName)
        let slotColumn = SlotColumn(slotElements: [slotElement], numberOfSlotElementsOnScreen: 3)
        
        let slotColumnViewModel = SlotColumnViewModel(slotColumn: slotColumn)
        let expectedImage = UIImage(named: fruitImageName)!
        
        XCTAssertTrue(slotColumnViewModel.imagesForColumn() == [expectedImage])
    }
    
    func testNumberOfSlotsOnScreen() {
        let fruitImageName = getFruitImageName()
        let slotElement = SlotElement(imageName: fruitImageName)
        let slotColumn = SlotColumn(slotElements: [slotElement], numberOfSlotElementsOnScreen: 3)
        
        let slotColumnViewModel = SlotColumnViewModel(slotColumn: slotColumn)
        
        XCTAssertTrue(slotColumnViewModel.numberOfSlotsOnScreen() == 3)
    }
}