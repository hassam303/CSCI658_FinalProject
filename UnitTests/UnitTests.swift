//
//  UnitTests.swift
//  UnitTests
//
//  Created by Hassam Solano-Morel on 4/18/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import UIKit
import XCTest
@testable import CSCI658_Final

class UnitTests: XCTestCase {
    private var vc:ViewController!
    private var lines:[UILabel]!
    private var optionBttns:[UIButton]!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main",bundle: Bundle.main)
        
        vc = storyboard.instantiateInitialViewController() as! ViewController
       
        UIApplication.shared.keyWindow!.rootViewController = vc
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(vc.view)
        lines = vc.linesArray
        optionBttns = vc.optionBttns
    }
    
    /*START TESTING HELPER METHODS*/
    private func enterValidPin(){
        enterNumber(Number: 1)
        enterNumber(Number: 2)
        enterNumber(Number: 3)
        enterNumber(Number: 4)
    }
    private func enterNumber(Number num:Int){
        vc.CONTEXT?.processAction(action: NumberEnteredAction(Number: String(num)))
    }
    private func initContext(ValidCard valid:Bool, DepositAllowed depAllowed:Bool){
        vc.CONTEXT = Context(StartBalance: 1000.0, DailyLimit: 500.0, ValidCard: valid, DepositsAllowed: depAllowed, Lines: lines, OptionButtons: optionBttns)
    }
    /*END TESTING HELPER METHODS*/

    
    //Test valid card
    func testUC1() {
        initContext(ValidCard: true, DepositAllowed: true)
        vc.didPressCardSlot(self)
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen2)
    }
    //Test invalid card
    func testUC2() {
        initContext(ValidCard: false, DepositAllowed: true)
        vc.didPressCardSlot(self)
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen4)
    }
    //Test valid pin number
    func testUC3(){
        initContext(ValidCard: true, DepositAllowed: true)

        vc.didPressCardSlot(self)
        enterValidPin()
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen5)
    }
    //Test invalid pin entries
    func testUC4(){
        initContext(ValidCard: true, DepositAllowed: true)
        vc.didPressCardSlot(self)
        
        //First failed entry
        enterNumber(Number: 1)
        enterNumber(Number: 1)
        enterNumber(Number: 1)
        enterNumber(Number: 1)

        vc.didPressEnter(self)//Press enter to retry

        //Second failed entry
        enterNumber(Number: 1)
        enterNumber(Number: 1)
        enterNumber(Number: 1)
        enterNumber(Number: 1)
        
        vc.didPressEnter(self)//Press enter to retry
        
        //Third failed entry
        enterNumber(Number: 1)
        enterNumber(Number: 1)
        enterNumber(Number: 1)
        enterNumber(Number: 1)
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen1)
    }
    //Test able to choose "balance" transaction
    func testUC5(){
        initContext(ValidCard: true, DepositAllowed: true)
        
        vc.didPressCardSlot(self)
        enterValidPin()
        
        vc.didPressOption1(self)//Choose "balance"
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen6)
    }
    //Test able to choose "deposit" transaction
    func testUC6(){
        initContext(ValidCard: true, DepositAllowed: true)
        
        vc.didPressCardSlot(self)
        enterValidPin()
        
        vc.didPressOption2(self)//Choose "balance"
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen13)
    }
    //Test jammed deposit slot
    func testUC7(){
        initContext(ValidCard: true, DepositAllowed: false)
        
        vc.didPressCardSlot(self)
        enterValidPin()
        
        vc.didPressOption2(self)//Choose "deposit"
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen12)
    }
    //Test "normal withdrawal"
    func testUC8() {
        initContext(ValidCard: true, DepositAllowed: true)
        
        vc.didPressCardSlot(self)
        enterValidPin()
        
        vc.didPressOption3(self)//Choose "withdrawal"
        
        enterNumber(Number: 1)
        enterNumber(Number: 0)
        enterNumber(Number: 0)
        
        vc.didPressEnter(self)
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen11)
    }
    //Test "not multiple of 10" withdrawal ($155)
    func testUC9(){
        initContext(ValidCard: true, DepositAllowed: true)
        
        vc.didPressCardSlot(self)
        enterValidPin()
        
        vc.didPressOption3(self)//Choose "withdrawal"
        
        enterNumber(Number: 1)
        enterNumber(Number: 5)
        enterNumber(Number: 5)
        
        vc.didPressEnter(self)
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen9)
    }
    //Test "insufficient funds" ($1,555)
    func testUC10() {
        initContext(ValidCard: true, DepositAllowed: true)
        
        vc.didPressCardSlot(self)
        enterValidPin()
        
        vc.didPressOption3(self)//Choose "withdrawal"
        
        enterNumber(Number: 1)
        enterNumber(Number: 5)
        enterNumber(Number: 5)
        enterNumber(Number: 5)

        vc.didPressEnter(self)
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen8)
    }
    //Test "over daily limit" ($510)
    func testUC11() {
        initContext(ValidCard: true, DepositAllowed: true)
        
        vc.didPressCardSlot(self)
        enterValidPin()
        
        vc.didPressOption3(self)//Choose "withdrawal"
        
        enterNumber(Number: 5)
        enterNumber(Number: 1)
        enterNumber(Number: 0)
        
        vc.didPressEnter(self)
        
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen10)
    }
}

