//
//  TriangleView.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

enum TriangleDirection {
    case Left
    case Right
}

class TriangleView: UIView {
    
    var triangleDirection: TriangleDirection = .Right
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        
        if let context: CGContextRef = UIGraphicsGetCurrentContext() {
            
            let posA: CGPoint
            let posB: CGPoint
            let posC: CGPoint
            
            switch triangleDirection {
            case .Left:
                posA = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect))
                posB = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))
                posC = CGPointMake(CGRectGetMinX(rect), (CGRectGetMaxY(rect)/2.0))
            case .Right:
                posA = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect))
                posB = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect))
                posC = CGPointMake(CGRectGetMaxX(rect), (CGRectGetMaxY(rect)/2.0))
            }
            
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, posA.x, posA.y)
            CGContextAddLineToPoint(context, posB.x, posB.y)
            CGContextAddLineToPoint(context, posC.x, posC.y)
            CGContextClosePath(context)
            
            let colorComponents = AppConstants.Colors.Pink.components
            CGContextSetRGBFillColor(context, colorComponents.red, colorComponents.green, colorComponents.blue, colorComponents.alpha)
            CGContextFillPath(context)
        }
    }
}