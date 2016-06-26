//
//  PrizeAlertView.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class PrizeAlertView: XibLoadingView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var claimButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        claimButton.backgroundColor = AppConstants.Colors.Green
        let claimButtonAttributedString = NSAttributedString(string: "CLAIM!", attributes: attributesForClaimButton())
        claimButton.setAttributedTitle(claimButtonAttributedString, forState: .Normal)
        claimButton.setAttributedTitle(claimButtonAttributedString, forState: .Highlighted)
    }
    
    func updateWithImage(image: UIImage, itemName: String) {
        
        let prefix = "FREE"
        let titleAttributedString = NSMutableAttributedString(string: "\(prefix) \(itemName.uppercaseString)", attributes: attributesForTitleLabel())
            
        let freeRange = NSRange(location: 0, length: prefix.characters.count)
        titleAttributedString.addAttribute(NSForegroundColorAttributeName, value: AppConstants.Colors.Pink, range: freeRange)
        
        titleLabel.attributedText = titleAttributedString
        imageView.image = image
    }
    
    private func attributesForClaimButton() -> [String : AnyObject] {
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        
        return [NSFontAttributeName: UIFont(name: "Verdana", size: 20.0)!,
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSParagraphStyleAttributeName: style]
    }
    
    private func attributesForTitleLabel() -> [String : AnyObject] {
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        
        return [NSFontAttributeName: UIFont(name: "Verdana", size: 30.0)!,
                NSForegroundColorAttributeName: UIColor.blackColor(),
                NSParagraphStyleAttributeName: style]
    }
    
    @IBAction func claimButtonTapped(sender: AnyObject) {
        self.removeFromSuperview()
    }
}