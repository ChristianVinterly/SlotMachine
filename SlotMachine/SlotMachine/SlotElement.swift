//
//  SlotElement.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

struct SlotElement: Equatable {
    let imageName: String
}

func ==(lhs: SlotElement, rhs: SlotElement) -> Bool {
    return lhs.imageName == rhs.imageName
}