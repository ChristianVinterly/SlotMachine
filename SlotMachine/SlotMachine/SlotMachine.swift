//
//  SlotMachine.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

struct SlotMachine: Equatable {
    let slotColumns: [SlotColumn]
}

func ==(lhs: SlotMachine, rhs: SlotMachine) -> Bool {
    return lhs.slotColumns == rhs.slotColumns
}