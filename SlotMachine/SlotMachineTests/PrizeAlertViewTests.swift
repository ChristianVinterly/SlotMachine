//
//  PrizeAlertViewTests.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import XCTest
@testable import SlotMachine

class PrizeAlertViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitializePrizeAlertView() {
        let prizeAlertView = PrizeAlertView(frame: CGRectZero)
        XCTAssertNotNil(prizeAlertView)
    }
    
    func testInitializePrizeAlertViewWithDecoder() {
        let coder = NSKeyedUnarchiver(forReadingWithData: NSMutableData())
        let prizeAlertView = PrizeAlertView(coder: coder)
        XCTAssertNotNil(prizeAlertView)
    }
    
    func testUpdateWithImageAndText() {
        
        let image = UIImage(named: "Apple")!
        let text = "Apple"
        let prizeAlertView = PrizeAlertView(frame: CGRectZero)
        prizeAlertView.updateWithImage(image, itemName: text)
        
        XCTAssertTrue(prizeAlertView.imageView.image == image)
        XCTAssertTrue(prizeAlertView.titleLabel.text == "FREE \(text.uppercaseString)")
    }
    
    func testClaimButtonTapped() {
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(viewController.view)
        
        let prizeAlertView = PrizeAlertView(frame: CGRectZero)
        viewController.view.addSubview(prizeAlertView)
        
        XCTAssertTrue(prizeAlertView.superview == viewController.view)
        
        prizeAlertView.claimButtonTapped("Button Tapped")
        
        XCTAssertTrue(prizeAlertView.superview == nil)

    }
}