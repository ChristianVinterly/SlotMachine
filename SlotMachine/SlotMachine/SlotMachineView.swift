//
//  SlotMachineView.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

protocol SlotMachineDelegate: class {
    func prizeWonWithImage(image: UIImage, itemName: String)
    func newSpinResult(spinResult: SpinResult)
}

typealias ColumnResult = (image: UIImage, columnIndex: Int)

class SlotMachineView: XibLoadingView {
    
    @IBOutlet var slotColumnViews: [SlotColumnView]!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var slotMachineFrameView: UIView!
    
    @IBOutlet weak var leftTriangleView: TriangleView!
    @IBOutlet weak var rightTriangleView: TriangleView!
    
    weak var slotMachineDelegate: SlotMachineDelegate?
    
    var spinState: SpinState = .ReadyToSpin {
        didSet {
            updateViewWithSpinState(spinState)
        }
    }
    
    private var spinResultImages: [ColumnResult] = []
    
    private let cornerRadius: CGFloat = 10
    private let borderWidth: CGFloat = 10
    
    private let animationDurationBase: CGFloat = 0.15
    private let animationDurationVarianse: UInt32 = 5
    private let animationDelayVarianse: UInt32 = 40
    private let animationDenominator: CGFloat = 100
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateStyleForSlotMachineFrameView()
        updateStyleForTriangles()
    }
    
    private func updateStyleForSlotMachineFrameView() {
        slotMachineFrameView.clipsToBounds = true
        slotMachineFrameView.layer.cornerRadius = cornerRadius
        slotMachineFrameView.layer.borderWidth = borderWidth
        slotMachineFrameView.layer.borderColor = AppConstants.Colors.Green.CGColor
    }
    
    private func updateStyleForTriangles() {
        leftTriangleView.triangleDirection = .Right
        rightTriangleView.triangleDirection = .Left
    }
}

extension SlotMachineView: Configurable {
    func configureViewWithViewModel(viewModel: Any) {
        guard let viewModel = viewModel as? SlotMachineViewModel else { return }
        
        let columnViewModels = viewModel.slotColumnViewModels()
        
        let delay = CGFloat(arc4random()%animationDelayVarianse)/animationDenominator
        
        for (index, slotColumnView) in slotColumnViews.enumerate() {
            if index < columnViewModels.count {
                slotColumnView.tag = index
                slotColumnView.configureViewWithViewModel(columnViewModels[index])
                slotColumnView.slotColumnDelegate = self
                slotColumnView.animationDelay = NSTimeInterval(CGFloat(index) * delay)
                slotColumnView.animationDuration = NSTimeInterval(animationDurationBase + CGFloat(arc4random()%animationDurationVarianse)/animationDenominator)
            }
        }
    }
}

extension SlotMachineView: SpinningObject {
    func updateViewWithSpinState(spinState: SpinState) {
        
        if spinState == .Spinning {
            spinResultImages = []
            
            let delay = CGFloat(arc4random()%animationDelayVarianse)/animationDenominator
            for (index, slotColumnView) in slotColumnViews.enumerate() {
                slotColumnView.animationDelay = NSTimeInterval(CGFloat(index) * delay)
                slotColumnView.animationDuration = NSTimeInterval(animationDurationBase + CGFloat(arc4random()%animationDurationVarianse)/animationDenominator)
            }
        }
        
        for slotColumnView in slotColumnViews {
            slotColumnView.spinState = spinState
        }
    }
}

extension SlotMachineView: SlotColumnDelegate {
    func stoppedOnImage(image: UIImage, itemName: String, columnIndex: Int) {
        spinResultImages.append((image, columnIndex))
        
        if spinResultImages.count == slotColumnViews.count {
            var wonPrize = false
            
            let images = spinResultImages.map{$0.image}
            
            if images.allEqual() {
                slotMachineDelegate?.prizeWonWithImage(image, itemName: itemName)
                wonPrize = true
            }
            
            let image1 = spinResultImages.filter{$0.columnIndex == 0}.map{$0.image}.first
            let image2 = spinResultImages.filter{$0.columnIndex == 1}.map{$0.image}.first
            let image3 = spinResultImages.filter{$0.columnIndex == 2}.map{$0.image}.first
            
            if let image1 = image1, image2 = image2, image3 = image3 {
                let newSpinResult = SpinResult(image1: image1,
                                               image2: image2,
                                               image3: image3,
                                               wonPrize: wonPrize)
                slotMachineDelegate?.newSpinResult(newSpinResult)
            }
        }
    }
}
