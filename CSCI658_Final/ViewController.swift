//
//  ViewController.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var CONTEXT:Context?
    var startBalance:Double = 1000.00
    var dailyLimit:Double = 500.00
    var validCard:Bool = true
    
    /*UI Components*/
    //Screen
    @IBOutlet weak var atmScreen: UIView!
    
    //Screen Lines
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var line3: UILabel!
    @IBOutlet weak var line4: UILabel!
    @IBOutlet weak var line5: UILabel!
    
    //Buttons
    @IBOutlet weak var cardSlotBttn: UIButton!
    @IBOutlet weak var enterBttn: UIButton!
    @IBOutlet weak var clearBttn: UIButton!
    @IBOutlet weak var canelBttn: UIButton!
    @IBOutlet weak var depositSlotBttn: UIButton!
    @IBOutlet weak var printedReceiptBttn: UIButton!
    @IBOutlet weak var cashDispenserBttn: UIButton!
    
    @IBOutlet weak var option1Bttn: UIButton!
    @IBOutlet weak var option2Bttn: UIButton!
    @IBOutlet weak var option3Bttn: UIButton!
    
    
    //Pin Pad Compenents
    @IBOutlet weak var pinPadCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pinPadCollectionView.delegate = self
        pinPadCollectionView.dataSource = self
        setUpContext()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*Action Listeners*/
    //PinPad
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell:PinPadCollectionViewCell = collectionView.cellForItem(at: indexPath) as! PinPadCollectionViewCell
        let action:NumberEnteredAction = NumberEnteredAction(Number: String(cell.value))
        self.CONTEXT?.processAction(action: action)
    }
    
    //Buttons
    @IBAction func didPressEnter(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "Enter")
        CONTEXT?.processAction(action: action)
    }
    @IBAction func didPressClear(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "Clear")
        CONTEXT?.processAction(action: action)
    }
    @IBAction func didPressCanel(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "Cancel")
        CONTEXT?.processAction(action: action)
    }
    @IBAction func didPressCardSlot(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "CardSlot")
        CONTEXT?.processAction(action: action)
    }
    @IBAction func didPressOption1(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "Option1")
        CONTEXT?.processAction(action: action)
    }
    @IBAction func didPressOption2(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "Option2")
        CONTEXT?.processAction(action: action)
    }
    @IBAction func didPressOption3(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "Option3")
        CONTEXT?.processAction(action: action)
    }
    
    @IBAction func didPressPrintedReceipt(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "PrintedReceipt")
        CONTEXT?.processAction(action: action)
    }
    
    @IBAction func didPressCashDispenser(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "CashDispenser")
        CONTEXT?.processAction(action: action)
    }
    
    @IBAction func didPressDepositSlot(_ sender: Any) {
        let action:ButtonPressedAction = ButtonPressedAction(Button: "DepositSlot")
        CONTEXT?.processAction(action: action)
    }
    
    //SetUp Methods
    private func setUpContext(){
        let linesArray:[UILabel] = [line1, line2, line3, line4, line5]
        let optionBttns:[UIButton] = [option1Bttn, option2Bttn, option3Bttn]
        
        self.CONTEXT = Context(StartBalance: startBalance, DailyLimit: dailyLimit, ValidCard: validCard,Lines: linesArray, OptionButtons: optionBttns)
    }
    
    
}


/*CollectionView Delegate Methods*/
extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PinPadCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pinPadCell", for: indexPath) as! PinPadCollectionViewCell
        
        cell.layer.borderWidth = 3.0
        
        if(indexPath.row == 9){
            cell.value = 0
        }else{
            cell.value = indexPath.row + 1

        }
        
        cell.lable.text = String(cell.value)
        
        return cell;
    }
}
