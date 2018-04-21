//
//  CSCI658_UITests.swift
//  CSCI658_UITests
//
//  Created by Hassam Solano-Morel on 4/18/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import XCTest

class UITests: XCTestCase {
    private var app:XCUIApplication!
    private var scrolledToBottom:Bool = false
    
    //References to UIElements
        //PinPad
    private var collectionView:XCUIElement!

        //All PinPad Cells
    private var cellsQuery:XCUIElementQuery!
    
        //PinPad Digits
    private var digit1:XCUIElement!
    private var digit2:XCUIElement!
    private var digit3:XCUIElement!
    private var digit4:XCUIElement!
    private var digit5:XCUIElement!
    
        //Buttons
    private var cardSlotBttn:XCUIElement!
    private var enterBttn:XCUIElement!
    private var depositSlotBttn:XCUIElement!
    private var cancelbttn:XCUIElement!
    
    private var option1Bttn:XCUIElement!
    private var option2Bttn:XCUIElement!
    private var option3Bttn:XCUIElement!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        collectionView = app.otherElements.containing(.collectionView, identifier: "pinPadCollectionView").element
        
        cellsQuery = app.collectionViews.cells
        
        digit1 = cellsQuery.element(boundBy: 0)
        digit2 = cellsQuery.element(boundBy: 1)
        digit3 = cellsQuery.element(boundBy: 2)
        digit4 = cellsQuery.element(boundBy: 3)
        digit5 = cellsQuery.element(boundBy: 4)
        
        cardSlotBttn = app.buttons["Card Slot"]
        enterBttn = app.buttons["Enter"]
        depositSlotBttn = app.buttons["Deposit slot"]
        cancelbttn = app.buttons["Cancel"]
        
        option1Bttn = app.buttons["Option1"]
        option2Bttn = app.buttons["Option2"]
        option3Bttn = app.buttons["Option3"]

        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        app.terminate()
    }
    
    /*START TESTING HELPER METHODS*/
    private func pressPinNumber(Number num:Int){
        switch num {
        case 0:
            if !scrolledToBottom{//0 is not visible
                collectionView.swipeUp()
                scrolledToBottom = true
            }
            cellsQuery.staticTexts["0"].tap()
            break
        case 1:
            if scrolledToBottom{//1 is not visible
                collectionView.swipeDown()
                scrolledToBottom = false
            }
            if digit1.exists {
                digit1.tap()
            }
            break
        case 2:
            if scrolledToBottom{//1 is not visible
                collectionView.swipeDown()
                scrolledToBottom = false
            }
            if digit2.exists {
                digit2.tap()
            }
            break
        case 3:
            if scrolledToBottom{//1 is not visible
                collectionView.swipeDown()
                scrolledToBottom = false
            }
            if digit3.exists {
                digit3.tap()
            }
            break
        case 4:
            if digit4.exists {
                digit4.tap()
            }
            break
        case 5:
            if digit5.exists{
                digit5.tap()
            }
        default:
            break
        }
    }
    
    private func enterValidPinNumber(){
        pressPinNumber(Number: 1)
        pressPinNumber(Number: 2)
        pressPinNumber(Number: 3)
        pressPinNumber(Number: 4)
    }
    /*END TESTING HELPER METHODS*/
    
    /*
     UC1: Valid Card - This can only be "directly" tested via unit tests
                        however because the default is is that the "card"
                        is valid, it can be said that this tested by
                        proximity by all of the following UITests
     UC2: Invalid Card - This can only be tested via unit test
     UC7: Jammed Deposit Slot - This can only be tested via unit tests
     */
    
    //Test valid pin
    func testUC3() {
        if cardSlotBttn.exists{
            cardSlotBttn.tap()
        }
        
        enterValidPinNumber()
        
        XCTAssert(app.staticTexts["Screen 5"].exists)
    }
    //Test invalid pin entries
    func testUC4() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        if cardSlotBttn.exists{
            cardSlotBttn.tap()
        }
        
        for _ in 1...3{
            if digit1.exists {
                pressPinNumber(Number: 1)
                pressPinNumber(Number: 1)
                pressPinNumber(Number: 1)
                pressPinNumber(Number: 1)
            }
            
            if enterBttn.exists{
                enterBttn.tap()
            }
        }
        
        XCTAssert(app.staticTexts["Screen 1"].exists)
        
    }
    //Test able to choose "balance" transaction [THIS USE CASE SHOULD FAIL]
    func testUC5() {

        if cardSlotBttn.exists{
            cardSlotBttn.tap()
        }
        
        //Set up preconditon : Screen5 displayed
        enterValidPinNumber()
        
        if app.staticTexts["Screen 5"].exists{//Precondition met
            if option1Bttn.exists{
                option1Bttn.tap()
                
                //Test for post condition: Screen5 displayed
                XCTAssert(app.staticTexts["Screen 5"].exists)
                
            }
        }
    }
    //Test able to choose "deposit" transaction [THIS USE CASE SHOULD FAIL]
    func testUC6() {
        if cardSlotBttn.exists{
            cardSlotBttn.tap()
        }
        
        //Set up preconditon : Screen5 displayed
       enterValidPinNumber()
        
        if app.staticTexts["Screen 5"].exists{//Precondition met
            if option2Bttn.exists{
                option2Bttn.tap()
                
                if depositSlotBttn.exists{
                    depositSlotBttn.tap()//e7: Insert deposit envelope
                    
                    if cancelbttn.exists{
                        cancelbttn.tap()//e15: No
                        
                        //Test for post condition: Screen1 displayed
                        XCTAssert(app.staticTexts["Screen 1"].exists)
                    }
                }
            }else{
                XCTFail("Option1 Button does not exist")
            }
        }else{
            XCTFail("Failed to achive precondition: Screen5 displayed")
        }
    }
    
    //Test "normal withdrawal"
    func testUC8() {
        
        cardSlotBttn.tap()
        
        enterValidPinNumber()

        option3Bttn.tap()
        cellsQuery.staticTexts["1"].tap()
        
        collectionView.swipeUp()//Make cell "0" visible
        
        cellsQuery.staticTexts["0"].tap()
        cellsQuery.staticTexts["0"].tap()

        enterBttn.tap()
        app.buttons["Cash dispenser"].tap()
        enterBttn.tap()
        
        XCTAssert(app.staticTexts["Screen 1"].exists)
        
    }
    //Test "not multiple of 10" withdrawal ($155)
    func testUC9() {
        
        cardSlotBttn.tap()
        
        enterValidPinNumber()
        
        option3Bttn.tap()
        cellsQuery.staticTexts["1"].tap()
        cellsQuery.staticTexts["5"].tap()
        cellsQuery.staticTexts["5"].tap()
        
        enterBttn.tap()
        XCTAssert(app.staticTexts["Screen 9"].exists)
        
    }
    //Test "insufficient funds" ($1,555)
    func testUC10() {
        
        cardSlotBttn.tap()
        
        enterValidPinNumber()
        
        option3Bttn.tap()
        cellsQuery.staticTexts["1"].tap()
        cellsQuery.staticTexts["5"].tap()
        cellsQuery.staticTexts["5"].tap()
        cellsQuery.staticTexts["5"].tap()

        
        enterBttn.tap()
        XCTAssert(app.staticTexts["Screen 8"].exists)
        
    }
    //Test "over daily limit" ($510)
    func testUC11() {
        
        cardSlotBttn.tap()
        
        enterValidPinNumber()
        
        option3Bttn.tap()
        
        cellsQuery.staticTexts["5"].tap()
        cellsQuery.staticTexts["1"].tap()

        collectionView.swipeUp()//Make cell "0" visible
        cellsQuery.staticTexts["0"].tap()
        
        enterBttn.tap()
        XCTAssert(app.staticTexts["Screen 10"].exists)
        
    }
    
}
