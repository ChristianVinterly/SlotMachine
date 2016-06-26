//
//  SlotMachineView.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class SlotMachineView: XibLoadingView {
    @IBOutlet var slotColumnViews: [SlotColumnView]!
}

extension SlotMachineView: Configurable {
    func configureViewWithViewModel(viewModel: Any) {
        guard let viewModel = viewModel as? SlotMachineViewModel else { return }
        
        let columnViewModels = viewModel.slotColumnViewModels()
        
        for (index, slotColumnView) in slotColumnViews.enumerate() {
            if index < columnViewModels.count {
                slotColumnView.configureViewWithViewModel(columnViewModels[index])
            }
        }
    }
}