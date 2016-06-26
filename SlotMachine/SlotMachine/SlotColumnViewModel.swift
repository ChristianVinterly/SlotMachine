//
//  SlotColumnViewModel.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

struct SlotColumnViewModel {
    let slotColumn: SlotColumn
    
    func imagesForColumn() -> [UIImage] {
        return slotColumn.slotElements.map{UIImage(named: $0.imageName)!}
    }
    
    func numberOfSlotsOnScreen() -> Int {
        return slotColumn.numberOfSlotElementsOnScreen
    }
}

func ==(lhs: SlotColumnViewModel, rhs: SlotColumnViewModel) -> Bool {
    return lhs.slotColumn == rhs.slotColumn
}