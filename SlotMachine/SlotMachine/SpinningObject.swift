//
//  SpinningObject.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation

enum SpinState {
    case ReadyToSpin
    case Spinning
    case Stop
}

protocol SpinningObject {
    var spinState: SpinState { get set }
    func updateViewWithSpinState(spinState: SpinState)
}