//
//  ViewController.swift
//  SlotMachine
//
//  Created by Christian Lysne on 26/06/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import UIKit

typealias SpinResult = (image1: UIImage, image2: UIImage, image3: UIImage, wonPrize: Bool)

class ViewController: UIViewController {

    @IBOutlet weak var slotMachineView: SlotMachineView!
    @IBOutlet weak var spinButton: SpinButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var separatorView: UIView!

    private var spinTimer: NSTimer!
    private var spinResults: [SpinResult] = []
    
    private let imageNames = ["Apple",
                              "Carrot",
                              "Lemon",
                              "Plum",
                              "Strawberry"]
    private let numberOfColumns = 3
    private let numberOfSlotElementsInColumnOnScreen = 2
    private let spinDuration: NSTimeInterval = 3
    private let spinResultCellIdentifier = "spinResultCell"
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppConstants.Colors.LightGray
        tableView.backgroundColor = AppConstants.Colors.LightGray
        separatorView.backgroundColor = AppConstants.Colors.Green
        
        let viewModel = SlotMachineViewModel.createSlotMachineViewModel(imageNames,
                                                                        numberOfColumns: numberOfColumns,
                                                                        numberOfSlotElementsInColumnOnScreen: numberOfSlotElementsInColumnOnScreen)
        slotMachineView.configureViewWithViewModel(viewModel)
        slotMachineView.slotMachineDelegate = self
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

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spinResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(spinResultCellIdentifier,
                                                               forIndexPath: indexPath) as! SpinResultTableViewCell
        let spinResult = spinResults[indexPath.row]
        cell.configureCellWithSpinResult(spinResult)
        
        return cell
    }
}

extension ViewController: SlotMachineDelegate {
    func prizeWonWithImage(image: UIImage, itemName: String) {
        let prizeAlertView = PrizeAlertView(frame: self.view.frame)
        prizeAlertView.updateWithImage(image, itemName: itemName)
        self.view.addSubview(prizeAlertView)
    }
    
    func newSpinResult(spinResult: SpinResult) {
        spinResults.insert(spinResult, atIndex: 0)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
    }
}