//
//  SpinResultTableViewCell.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class SpinResultTableViewCell: UITableViewCell {
    
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var resultImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    func configureCellWithSpinResult(spinResult: SpinResult) {
        imageViews[0].image = spinResult.image1
        imageViews[1].image = spinResult.image2
        imageViews[2].image = spinResult.image3
        
        if spinResult.wonPrize {
            resultImageView.image = spinResult.image1
        } else {
            resultImageView.image = UIImage(named: "Empty")!
        }
    }
}