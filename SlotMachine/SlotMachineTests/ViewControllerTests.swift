//
//  TestViewController.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import XCTest
@testable import SlotMachine

class ViewControllerTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        self.viewController = storyboard.instantiateInitialViewController() as! ViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(viewController.view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSpinButtonTapped() {
        
        XCTAssertTrue(viewController.spinButton.buttonState == .ReadyToSpin)
        XCTAssertTrue(viewController.spinButton.enabled)
        
        viewController.spinButtonTapped("Tapped button")
        
        XCTAssertTrue(viewController.spinButton.buttonState == .Spinning)
        XCTAssertFalse(viewController.spinButton.enabled)
    }
}
