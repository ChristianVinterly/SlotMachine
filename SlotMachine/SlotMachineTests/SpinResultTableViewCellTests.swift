//
//  SpinResultTableViewCellTests.swift
//  SlotMachine
//
//  Created by Christian Lysne on 27/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import XCTest
@testable import SlotMachine

class SpinResultTableViewCellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitializeSpinResultTableViewCellWithReuseIdentifier() {
        let spinResultTableViewCell = SpinResultTableViewCell(style: UITableViewCellStyle.Default,
                                                              reuseIdentifier: "spinResultCell")
        XCTAssertNotNil(spinResultTableViewCell)
    }
    
    func testInitializeSpinResultTableViewCellWithDecoder() {
        let coder = NSKeyedUnarchiver(forReadingWithData: NSMutableData())
        let spinResultTableViewCell = SpinResultTableViewCell(coder: coder)
        XCTAssertNotNil(spinResultTableViewCell)
    }
    
    func testConfigureCellWithSpinResult() {
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(viewController.view)
        
        let spinResultTableViewCell = viewController.tableView.dequeueReusableCellWithIdentifier("spinResultCell") as! SpinResultTableViewCell
        
        let image = UIImage(named: "Apple")!
        let spinResult = SpinResult(image1: image, image2: image, image3: image, wonPrize: true)
        
        spinResultTableViewCell.configureCellWithSpinResult(spinResult)
        
        XCTAssertTrue(spinResultTableViewCell.resultImageView.image == image)
    }
}