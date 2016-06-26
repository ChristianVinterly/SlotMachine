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
    
    private let paddingBetweenElements: CGFloat = 15
    private var numberOfImageViewsOnScreen: Int = 3 //Default
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateImageViewFrames()
    }
    
    func updateImageViewFrames() {
        
        let imageViewHeight = (self.frame.height - (paddingBetweenElements * CGFloat(numberOfImageViewsOnScreen-1)))/CGFloat(numberOfImageViewsOnScreen-1)
        
        for (i, imageView) in imageViews.enumerate() {
            let yPos = CGFloat(i) * imageViewHeight
            let offset = 0.5 * imageViewHeight
            let padding = i == 0 ? 0 : (paddingBetweenElements * CGFloat(i))
            imageView.frame = CGRectMake(0, yPos - offset + padding, self.frame.width, imageViewHeight)
        }
    }
}

extension SlotColumnView: Configurable {
    
    func configureViewWithViewModel(viewModel: Any) {
        guard let viewModel = viewModel as? SlotColumnViewModel else { return }
        
        images = viewModel.imagesForColumn()
        
        self.numberOfImageViewsOnScreen = viewModel.numberOfSlotsOnScreen()
        
        for i in 0..<numberOfImageViewsOnScreen {
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