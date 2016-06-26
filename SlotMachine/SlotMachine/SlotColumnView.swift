//
//  SlotColumnView.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

protocol SlotColumnDelegate: class {
    func stoppedOnImage(image: UIImage, itemName: String, columnIndex: Int)
}

class SlotColumnView: UIView {
    
    weak var slotColumnDelegate: SlotColumnDelegate?
    
    var images: [UIImage] = []
    var imageNames: [String] = []
    var imageViews: [UIImageView] = []
    
    var spinState: SpinState = .ReadyToSpin {
        didSet {
            updateViewWithSpinState(spinState)
        }
    }
    
    var animationDelay: NSTimeInterval = 0
    var animationDuration: NSTimeInterval = 0.2
    var selectedViewYPos: CGFloat = 0
    
    private var numberOfImageViewsOnScreen: Int = 3 //Default
    private var nextImageIndexToDisplay = 0
    
    private var imageViewHeight: CGFloat {
        get {
            return (self.frame.height - (paddingBetweenElements * CGFloat(numberOfImageViewsOnScreen)))/CGFloat(numberOfImageViewsOnScreen)
        }
    }
    
    private let paddingBetweenElements: CGFloat = 15
    private let startOffset: CGFloat = 1.5
    private let alphaFocused: CGFloat = 1.0
    private let alphaUnfocused: CGFloat = 0.6
    
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
            let padding = paddingBetweenElements * CGFloat(i - 1)
            imageView.frame = CGRectMake(0, yPos - offset + padding, self.frame.width, imageViewHeight)
            
            if imageViews.count/2 == i {
                selectedViewYPos = imageView.frame.minY
                imageView.alpha = alphaFocused
            } else {
                imageView.alpha = alphaUnfocused
            }
            self.updateStyleForImageView(imageView, isFocused: imageView == self.focusedImageView())
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
        
        self.updateStyleForImageView(imageView, isFocused: false)
        imageView.alpha = alphaFocused
        
        UIView.animateWithDuration(animationDuration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: {
            imageView.frame = destinationFrame
            }) { (finished) in
                if self.isImageViewAtBottomPosition(imageView) {
                    self.resetImageViewPositionToTop(imageView)
                }
                if self.spinState == .Stop || self.spinState == .ReadyToSpin {
                    self.spinState == .ReadyToSpin
                    self.updateStyleForImageView(imageView, isFocused: imageView == self.focusedImageView())
                    
                    if let image = self.focusedImageView()?.image where imageView == self.imageViews.last {
                        self.slotColumnDelegate?.stoppedOnImage(image,
                                                                itemName: self.itemNameForImage(image),
                                                                columnIndex: self.tag)
                    }
                    
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
        imageView.image = getNextImage()
        imageView.frame = CGRectMake(0, -offset - paddingBetweenElements, self.frame.width, self.imageViewHeight)
    }
    
    private func getNextImage() -> UIImage {
        if images.count > nextImageIndexToDisplay {
            let image = images[nextImageIndexToDisplay]
            nextImageIndexToDisplay += 1
            return image
        } else {
            nextImageIndexToDisplay = 1
            return images[0]
        }
    }
    
    private func focusedImageView() -> UIImageView? {
        
        var closestImageView: UIImageView?
        var closestDistance = CGFloat.max
        
        for imageView in imageViews {
            let yDist = selectedViewYPos - imageView.frame.midY
            let distance = sqrt(yDist * yDist)
            
            if distance < closestDistance {
                closestDistance = distance
                closestImageView = imageView
            }
        }
        
        return closestImageView
    }
    
    private func updateStyleForImageView(imageView: UIImageView, isFocused: Bool) {
        imageView.alpha = isFocused ? self.alphaFocused : self.alphaUnfocused
        imageView.layer.shadowColor = UIColor.yellowColor().CGColor
        imageView.layer.shadowOpacity = isFocused ? 1 : 0
        imageView.layer.shadowOffset = CGSizeZero
        imageView.layer.shadowRadius = isFocused ? 5 : 0
    }
    
    private func itemNameForImage(image: UIImage) -> String {
        for (index, imageInImages) in images.enumerate() {
            if image == imageInImages {
                return imageNames[index]
            }
        }
        return ""
    }
}

extension SlotColumnView: Configurable {
    
    func configureViewWithViewModel(viewModel: Any) {
        guard let viewModel = viewModel as? SlotColumnViewModel else { return }
        
        images = viewModel.imagesForColumn()
        imageNames = viewModel.itemNamesForColumn()
        
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
        
        if numberOfImageViews > images.count {
            nextImageIndexToDisplay = numberOfImageViews
        } else {
            nextImageIndexToDisplay = 0
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