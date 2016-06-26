//
//  ViewController.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slotMachineView: SlotMachineView!
    
    private let imageNames = ["Apple",
                              "Carrot",
                              "Lemon",
                              "Plum",
                              "Strawberry"]
    private let numberOfColumns = 3
    private let numberOfSlotElementsInColumnOnScreen = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = SlotMachineViewModel.createSlotMachineViewModel(imageNames,
                                                                        numberOfColumns: numberOfColumns,
                                                                        numberOfSlotElementsInColumnOnScreen: numberOfSlotElementsInColumnOnScreen)
        slotMachineView.configureViewWithViewModel(viewModel)
    }
}

