//
//  SlotMachineViewModel.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

struct SlotMachineViewModel {
    let slotMachine: SlotMachine
    
    func slotColumnViewModels() -> [SlotColumnViewModel] {
        return slotMachine.slotColumns.map{SlotColumnViewModel(slotColumn: $0)}
    }
    
    static func createSlotMachineViewModel(imageNames: [String],
                                           numberOfColumns: Int,
                                           numberOfSlotElementsInColumnOnScreen: Int) -> SlotMachineViewModel {
        
        let slotElements = imageNames.map{SlotElement(imageName: $0)}
        
        var slotColumns: [SlotColumn] = []
        for _ in 0..<numberOfColumns {
            let slotColumn = SlotColumn(slotElements: slotElements,
                                        numberOfSlotElementsOnScreen: numberOfSlotElementsInColumnOnScreen)
            slotColumns.append(slotColumn)
        }
        
        let slotMachine = SlotMachine(slotColumns: slotColumns)
        
        return SlotMachineViewModel(slotMachine: slotMachine)
    }
}
