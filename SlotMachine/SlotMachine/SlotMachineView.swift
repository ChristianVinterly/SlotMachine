//
//  SlotMachineView.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class SlotMachineView: XibLoadingView {
    
    @IBOutlet var slotColumnViews: [SlotColumnView]!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var slotMachineFrameView: UIView!
    
    @IBOutlet weak var leftTriangleView: TriangleView!
    @IBOutlet weak var rightTriangleView: TriangleView!
    
    var spinState: SpinState = .ReadyToSpin {
        didSet {
            updateViewWithSpinState(spinState)
        }
    }
    
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
                slotColumnView.configureViewWithViewModel(columnViewModels[index])
                slotColumnView.animationDelay = NSTimeInterval(CGFloat(index) * delay)
                slotColumnView.animationDuration = NSTimeInterval(animationDurationBase + CGFloat(arc4random()%animationDurationVarianse)/animationDenominator)
            }
        }
    }
}

extension SlotMachineView: SpinningObject {
    func updateViewWithSpinState(spinState: SpinState) {
        for slotColumnView in slotColumnViews {
            slotColumnView.spinState = spinState
        }
    }
}