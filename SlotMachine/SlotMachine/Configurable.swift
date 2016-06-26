//
//  ConfigurableSlotColumn.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

protocol Configurable {
    func configureViewWithViewModel(viewModel: Any)
}