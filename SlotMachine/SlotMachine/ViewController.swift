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
    @IBOutlet weak var spinButton: SpinButton!
    
    private var spinTimer: NSTimer!
    
    private let imageNames = ["Apple",
                              "Carrot",
                              "Lemon",
                              "Plum",
                              "Strawberry"]
    private let numberOfColumns = 3
    private let numberOfSlotElementsInColumnOnScreen = 2
    private let spinDuration: NSTimeInterval = 3
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppConstants.Colors.LightGray
        
        let viewModel = SlotMachineViewModel.createSlotMachineViewModel(imageNames,
                                                                        numberOfColumns: numberOfColumns,
                                                                        numberOfSlotElementsInColumnOnScreen: numberOfSlotElementsInColumnOnScreen)
        slotMachineView.configureViewWithViewModel(viewModel)
    }
    
    //MARK: IBActions
    @IBAction func spinButtonTapped(sender: AnyObject) {
        if spinButton.buttonState == .ReadyToSpin {
            spinButton.buttonState = .Spinning
            slotMachineView.spinState = .Spinning
            
            spinTimer = NSTimer.scheduledTimerWithTimeInterval(spinDuration,
                                                               target: self,
                                                               selector: #selector(ViewController.stopSpinning),
                                                               userInfo: nil,
                                                               repeats: false)
        }
    }
    
    //MARK: Selectors
    func stopSpinning() {
        spinTimer.invalidate()
        slotMachineView.spinState = .Stop
        spinButton.buttonState = .ReadyToSpin
    }
}

