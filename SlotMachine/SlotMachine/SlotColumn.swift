//
//  SlotColumn.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

struct SlotColumn: Equatable {
    let slotElements: [SlotElement]
    let numberOfSlotElementsOnScreen: Int
}

func ==(lhs: SlotColumn, rhs: SlotColumn) -> Bool {
    return lhs.slotElements == rhs.slotElements &&
        lhs.numberOfSlotElementsOnScreen == rhs.numberOfSlotElementsOnScreen
}