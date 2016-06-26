//
//  SlotColumnView.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SlotColumnView: UIView {
    var images: [UIImage] = []
    var imageViews: [UIImageView] = []
}

extension SlotColumnView: Configurable {
    func configureViewWithViewModel(viewModel: Any) {
        guard let viewModel = viewModel as? SlotColumnViewModel else { return }
        
        images = viewModel.imagesForColumn()
        
        let numberOfImageViewsToRotate = viewModel.numberOfSlotsOnScreen()
        let imageViewHeight = self.frame.height/CGFloat(viewModel.numberOfSlotsOnScreen() - 1)
        
        for i in 0..<numberOfImageViewsToRotate {
            if i < images.count {
                let imageView = UIImageView(image: images[i])
                imageView.frame = CGRectMake(0, CGFloat(i) * imageViewHeight - 0.5 * imageViewHeight, self.frame.width, imageViewHeight)
                addSubview(imageView)
                imageViews.append(imageView)
            }
        }
    }
}