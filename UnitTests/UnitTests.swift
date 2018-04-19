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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main",bundle: Bundle.main)
        
        
        vc = storyboard.instantiateInitialViewController() as! ViewController
        UIApplication.shared.keyWindow!.rootViewController = vc
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(vc.view)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUC1() {
        vc.CONTEXT = Context(StartBalance: 1000.0, DailyLimit: 500.0, ValidCard: true, Lines: vc.linesArray!, OptionButtons: vc.optionBttns!)
        
        vc.didPressCardSlot(self)
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen2)
    }
    
    func testUC2() {
        vc.CONTEXT = Context(StartBalance: 1000.0, DailyLimit: 500.0, ValidCard: false, Lines: vc.linesArray!, OptionButtons: vc.optionBttns!)
        
        vc.didPressCardSlot(self)
        XCTAssertTrue(vc.CONTEXT?.CURRENT_STATE is Screen4)
    }
    
}
