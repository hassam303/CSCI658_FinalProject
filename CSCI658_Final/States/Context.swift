//
//  Context.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/12/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import UIKit

class Context{
    var balance:Double
    var dailyLimit:Double
    var validCard:Bool
    var withdrawnToday: Double
    var failedPinAttempts:Int
    
    //References to text lines
    var line1:UILabel
    var line2:UILabel
    var line3:UILabel
    var line4:UILabel
    var line5:UILabel
    
    //References to button
    var option1:UIButton
    var option2:UIButton
    var option3:UIButton
    
    //Available State References
    let SCREEN1:Screen1 = Screen1()
    let SCREEN2:Screen2 = Screen2()
    let SCREEN3:Screen3 = Screen3()
    let SCREEN4:Screen4 = Screen4()
    let SCREEN5:Screen5 = Screen5()
    let SCREEN6:Screen6 = Screen6()
    let SCREEN7:Screen7 = Screen7()
    let SCREEN8:Screen8 = Screen8()
    let SCREEN9:Screen9 = Screen9()
    let SCREEN10:Screen10 = Screen10()
    let SCREEN11:Screen11 = Screen11()
    let SCREEN12:Screen12 = Screen12()
    let SCREEN13:Screen13 = Screen13()
    let SCREEN14:Screen14 = Screen14()
    let SCREEN15:Screen15 = Screen15()
    
    //Current State Reference
    var CURRENT_STATE:State
    
    
    init(StartBalance balance:Double, DailyLimit limit:Double,ValidCard valid:Bool ,Lines lines:[UILabel], OptionButtons optionButtons:[UIButton]){
        self.balance = balance
        self.dailyLimit = limit
        self.validCard = valid
        self.withdrawnToday = 0.0
        self.failedPinAttempts = 0
        
        self.line1 = lines[0]
        self.line2 = lines[1]
        self.line3 = lines[2]
        self.line4 = lines[3]
        self.line5 = lines[4]
        
        self.option1 = optionButtons[0]
        self.option2 = optionButtons[1]
        self.option3 = optionButtons[2]
        
        self.CURRENT_STATE = SCREEN1
        
        //Additional init for some screens
        SCREEN1.attachContext(context:self)
        
        SCREEN2.attachContext(context:self)
        
        SCREEN6.attachContext(context:self)
        
        SCREEN7.balance = self.balance
        SCREEN7.dailyLimit = self.dailyLimit
        SCREEN7.attachContext(context: self)

        loadState()
    }
    
    func processAction(action:ActionResponse){
        print("From ViewController: " + action.action)
        let contextAction = CURRENT_STATE.processAction(action: action)
        print("State Response: " + contextAction.action)
        
        //ChangeButtonColor
        if contextAction is ChangeButtonColorAction{
            let button = contextAction.item
            let color = contextAction.color
            
        }
            //Transition
        else if contextAction is TransitionAction{
            let toScreen = contextAction.item
            var nextScreen:Int
            
            switch toScreen{
            case "Screen 1":
                nextScreen = 1
                break
            case "Screen 2":
                nextScreen = 2
                break
            case "Screen 3":
                nextScreen = 3
                break
            case "Screen 4":
                nextScreen = 4
                break
            case "Screen 5":
                nextScreen = 5
                break
            case "Screen 6":
                nextScreen = 6
                break
            case "Screen 7":
                nextScreen = 7
                break
            case "Screen 8":
                nextScreen = 8
                break
            case "Screen 9":
                nextScreen = 9
                break
            case "Screen 10":
                nextScreen = 10
                break
            case "Screen 11":
                nextScreen = 11
                break
            case "Screen 12":
                nextScreen = 12
                break
            case "Screen 13":
                nextScreen = 13
                break
            case "Screen 14":
                nextScreen = 14
                break
            case "Screen 15":
                nextScreen = 15
                break
            default:
                print("HERE!!")
                
                nextScreen = 0
            }
            transitionToScreen(number: nextScreen)
        }
            //NumberEnteredAction
        else if contextAction is NumberEnteredAction{
            print("UH-OH The context should NEVER get a NumberEnterdAction")
        }
            //UpdateDisplayAction
        else if contextAction is UpdateDisplayAction{
            updateLine(line: contextAction.item)
        }
            //ButtonPressAction
        else if contextAction is ButtonPressedAction{
            print("UH-OH The context should NEVER get a ButtonPressedAction")
        }
            //BalanceChangeAction
        else if contextAction is BalanceChangeAction{
            updateBalance(newBalance: contextAction.item)
        }
            //NoAction
        else{
            
        }
    }
    
    func transitionToScreen(number:Int){
        var nextScreen:State
        
        switch number{
        case 1:
            nextScreen = SCREEN1
            break
        case 2:
            nextScreen = SCREEN2
            break
        case 3:
            nextScreen = SCREEN3
            break
        case 4:
            nextScreen = SCREEN4
            break
        case 5:
            nextScreen = SCREEN5
            break
        case 6:
            nextScreen = SCREEN6
            break
        case 7:
            nextScreen = SCREEN7
            break
        case 8:
            nextScreen = SCREEN8
            break
        case 9:
            nextScreen = SCREEN9
            break
        case 10:
            nextScreen = SCREEN10
            break
        case 11:
            nextScreen = SCREEN11
            break
        case 12:
            nextScreen = SCREEN12
            break
        case 13:
            nextScreen = SCREEN13
            break
        case 14:
            nextScreen = SCREEN14
            break
        case 15:
            nextScreen = SCREEN15
            break
        default:
            nextScreen = CURRENT_STATE
            break
        }
        
        if CURRENT_STATE.allowsTransition(state: nextScreen){
            CURRENT_STATE = nextScreen
            loadState()
        }
        
    }
    
    private func loadState(){
        line1.text = CURRENT_STATE.getLine1()
        line2.text = CURRENT_STATE.getLine2()
        line3.text = CURRENT_STATE.getLine3()
        line4.text = CURRENT_STATE.getLine4()
        line5.text = CURRENT_STATE.getLine5()
    }
    
    private func updateLine(line:String){
        switch line{
        case "Line 1":
            line1.text = CURRENT_STATE.getLine1()
            break
        case "Line 2":
            print("UPDATING LINE 2")
            line2.text = CURRENT_STATE.getLine2()
            break
        case "Line 3":
            line3.text = CURRENT_STATE.getLine3()
            break
        case "Line 4":
            line4.text = CURRENT_STATE.getLine4()
            break
        case "Line 5":
            line5.text = CURRENT_STATE.getLine5()
            break
        default:
            break
        }
    }
    
    private func updateBalance(newBalance:String){
        balance = Double(newBalance)!
    }

}
