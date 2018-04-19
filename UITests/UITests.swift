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
    
    //Test valid pin [THIS USE CASE SHOULD FAIL]
    func testUC3() {
        if cardSlotBttn.exists{
            cardSlotBttn.tap()
        }
        
        if digit1.exists {
            digit1.tap()
        }
        if digit2.exists {
            digit2.tap()
        }
        if digit3.exists {
            digit3.tap()
        }
        if digit4.exists {
            digit4.tap()
        }
        
        XCTAssert(app.staticTexts["Screen 6"].exists)
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
                digit1.tap()
                digit1.tap()
                digit1.tap()
                digit1.tap()
            }
            
            let enter = app.buttons["Enter"]
            if enter.exists{
                enter.tap()
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
        if digit1.exists {
            digit1.tap()//Press 1
        }
        if digit2.exists {
            digit2.tap()//Press 2
        }
        if digit3.exists {
            digit3.tap()//Press 3
        }
        if digit4.exists {
            digit4.tap()//Press 4
        }
        
        if app.staticTexts["Screen 5"].exists{//Precondition met
            if option1Bttn.exists{
                option1Bttn.tap()
                
                //Test for post condition: Screen5 displayed
                XCTAssert(app.staticTexts["Screen 5"].exists)
                
            }else{
                XCTFail("Option1 Button does not exist")
            }
        }else{
            XCTFail("Failed to achive precondition: Screen5 displayed")
        }
    }
    //Test able to choose "deposit" transaction [THIS USE CASE SHOULD FAIL]
    func testUC6() {
        if cardSlotBttn.exists{
            cardSlotBttn.tap()
        }
        
        //Set up preconditon : Screen5 displayed
        if digit1.exists {
            digit1.tap()//Press 1
        }
        if digit2.exists {
            digit2.tap()//Press 2
        }
        if digit3.exists {
            digit3.tap()//Press 3
        }
        if digit4.exists {
            digit4.tap()//Press 4
        }
        
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
    
    
    
    /*------------INSERT TEST 7 HERE---------------*/
    
    
    //Test "normal withdrawal"
    func testUC8() {
        
        cardSlotBttn.tap()
    
        cellsQuery.staticTexts["1"].tap()
        cellsQuery.staticTexts["2"].tap()
        cellsQuery.staticTexts["3"].tap()
        cellsQuery.staticTexts["4"].tap()

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
        
        cellsQuery.staticTexts["1"].tap()
        cellsQuery.staticTexts["2"].tap()
        cellsQuery.staticTexts["3"].tap()
        cellsQuery.staticTexts["4"].tap()
        
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
        
        cellsQuery.staticTexts["1"].tap()
        cellsQuery.staticTexts["2"].tap()
        cellsQuery.staticTexts["3"].tap()
        cellsQuery.staticTexts["4"].tap()
        
        option3Bttn.tap()
        cellsQuery.staticTexts["1"].tap()
        cellsQuery.staticTexts["5"].tap()
        cellsQuery.staticTexts["5"].tap()
        cellsQuery.staticTexts["5"].tap()

        
        enterBttn.tap()
        XCTAssert(app.staticTexts["Screen 8"].exists)
        
    }
    //Test "insufficient funds" ($510)
    func testUC11() {
        
        cardSlotBttn.tap()
        
        cellsQuery.staticTexts["1"].tap()
        cellsQuery.staticTexts["2"].tap()
        cellsQuery.staticTexts["3"].tap()
        cellsQuery.staticTexts["4"].tap()
        
        option3Bttn.tap()
        
        cellsQuery.staticTexts["5"].tap()
        cellsQuery.staticTexts["1"].tap()

        collectionView.swipeUp()//Make cell "0" visible
        cellsQuery.staticTexts["0"].tap()
        
        enterBttn.tap()
        XCTAssert(app.staticTexts["Screen 10"].exists)
        
    }
    
}
