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
    
    private let cornerRadius: CGFloat = 10
    private let alphaWhenReady: CGFloat = 1.0
    private let alphaWhenSpinning: CGFloat = 0.4
    
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
        layer.cornerRadius = cornerRadius
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
            alpha = alphaWhenReady
            titleAttributedString = NSAttributedString(string: "Spin", attributes: attributesForTitle())
        case .Spinning:
            enabled = false
            alpha = alphaWhenSpinning
            titleAttributedString = NSAttributedString(string: "Spinning...", attributes: attributesForTitle())
        }
        
        setAttributedTitle(titleAttributedString, forState: .Normal)
        setAttributedTitle(titleAttributedString, forState: .Highlighted)
    }
}