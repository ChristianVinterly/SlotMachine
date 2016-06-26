//
//  SlotColumnView.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class SlotColumnView: UIView {
    var images: [UIImage] = []
    var imageViews: [UIImageView] = []
    
    var spinState: SpinState = .ReadyToSpin {
        didSet {
            updateViewWithSpinState(spinState)
        }
    }
    
    var animationDelay: NSTimeInterval = 0
    var animationDuration: NSTimeInterval = 0.2
    
    private var numberOfImageViewsOnScreen: Int = 3 //Default
    
    private var imageViewHeight: CGFloat {
        get {
            return (self.frame.height - (paddingBetweenElements * CGFloat(numberOfImageViewsOnScreen)))/CGFloat(numberOfImageViewsOnScreen)
        }
    }
    
    private let paddingBetweenElements: CGFloat = 15
    private let startOffset: CGFloat = 1.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateImageViewFrames()
    }
    
    private func updateImageViewFrames() {
        for (i, imageView) in imageViews.enumerate() {
            let yPos = CGFloat(i) * imageViewHeight
            let offset = startOffset * imageViewHeight
            let padding = paddingBetweenElements * CGFloat(i)
            imageView.frame = CGRectMake(0, yPos - offset + padding, self.frame.width, imageViewHeight)
        }
    }
    
    private func startSpinning() {
        for imageView in imageViews {
            animateImageView(imageView, delay: animationDelay)
        }
    }
    
    private func animateImageView(imageView: UIImageView, delay: NSTimeInterval) {
        
        let destinationY = imageView.frame.origin.y + paddingBetweenElements + imageViewHeight
        let destinationFrame = CGRect(x: 0, y: destinationY, width: imageView.frame.width, height: imageView.frame.height)
        
        UIView.animateWithDuration(animationDuration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: {
            imageView.frame = destinationFrame
            }) { (finished) in
                if self.isImageViewAtBottomPosition(imageView) {
                    self.resetImageViewPositionToTop(imageView)
                }
                if self.spinState == .Stop || self.spinState == .ReadyToSpin {
                    self.spinState == .ReadyToSpin
                    return
                }
                self.animateImageView(imageView, delay: 0)
        }
    }
    
    private func isImageViewAtBottomPosition(imageView: UIImageView) -> Bool {
        return imageView.frame.origin.y >= self.frame.maxY + self.imageViewHeight/2 + self.paddingBetweenElements
    }
    
    private func resetImageViewPositionToTop(imageView: UIImageView) {
        let offset = self.startOffset * self.imageViewHeight
        imageView.frame = CGRectMake(0, -offset, self.frame.width, self.imageViewHeight)
    }
}

extension SlotColumnView: Configurable {
    
    func configureViewWithViewModel(viewModel: Any) {
        guard let viewModel = viewModel as? SlotColumnViewModel else { return }
        
        images = viewModel.imagesForColumn()
        
        self.numberOfImageViewsOnScreen = viewModel.numberOfSlotsOnScreen()
        
        /* Create one more imageView, so we can show 2 half imageViews with offset and
        // one more so we can smoothly rotate between imageViews while scrolling*/
        let numberOfImageViews = numberOfImageViewsOnScreen + 2
        
        for i in 0..<numberOfImageViews {
            if i < images.count {
                let imageView = UIImageView(image: images[i])
                imageView.contentMode = .ScaleAspectFit
                addSubview(imageView)
                imageViews.append(imageView)
            }
        }
        
        updateImageViewFrames()
    }
}

extension SlotColumnView: SpinningObject {
    func updateViewWithSpinState(spinState: SpinState) {
        switch spinState {
        case .ReadyToSpin:
            break
        case .Spinning:
            startSpinning()
        case .Stop:
            break
        }
    }
}