//
//  SpinButton.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

enum ButtonState {
    case ReadyToSpin
    case Spinning
}

class SpinButton: UIButton {
 
    var buttonState: ButtonState = .ReadyToSpin {
        didSet {
            updateButtonWithButtonState(buttonState)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.buttonState = .ReadyToSpin
        backgroundColor = AppConstants.Colors.Pink
        layer.cornerRadius = 10
    }
    
    private func attributesForTitle() -> [String : AnyObject] {
        return [NSFontAttributeName: UIFont(name: "Verdana", size: 20.0)!,
                NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    
    private func updateButtonWithButtonState(buttonState: ButtonState) {
        
        let titleAttributedString: NSAttributedString
        
        switch buttonState {
        case .ReadyToSpin:
            enabled = true
            alpha = 1.0
            titleAttributedString = NSAttributedString(string: "Spin", attributes: attributesForTitle())
        case .Spinning:
            enabled = false
            alpha = 0.4
            titleAttributedString = NSAttributedString(string: "Spinning...", attributes: attributesForTitle())
        }
        
        setAttributedTitle(titleAttributedString, forState: .Normal)
        setAttributedTitle(titleAttributedString, forState: .Highlighted)
    }
}