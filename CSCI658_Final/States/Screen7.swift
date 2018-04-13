//
//  Screen2.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen7:State{
    
    var amountToBeWithdrawn:[Int] = []
    var withdrawString = ""
    var context:Context?
    
    var balance:Double = 0.0
    var dailyLimit:Double = 0.0
    
    func getLine1() -> String {
        return "Screen 7"
    }
    
    func getLine2() -> String {
        self.withdrawString = produceAmount()
        return withdrawString
    }
    
    func getLine3() -> String {
        return "Enter Amount."
    }
    
    func getLine4() -> String {
        return "Withdrawals must"
    }
    
    func getLine5() -> String {
        return "be multiples of $10"
    }
    
    func allowsTransition(state: State) -> Bool {
        if state is Screen8 {
            return true
        }else if state is Screen9 {
            return true
        }else if state is Screen10 {
            return true
        }else if state is Screen11 {
            return true
        }
        
        return false
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        
        if action is NumberEnteredAction{
            print("IN HERE")
            self.amountToBeWithdrawn.append(Int(action.item)!)
            return UpdateDisplayAction(Line: "Line 2")
        }
        else if action is ButtonPressedAction{
            self.amountToBeWithdrawn.removeAll()
            if action.item == "Enter"{
                if isValidAmount(){
                    reset(valid: true)
                    return TransitionAction(Screen: "Screen 11")
                }else{
                    if invalidReason() == "insufficient"{
                        reset(valid: false)
                        return TransitionAction(Screen: "Screen 8")
                    }else if invalidReason() == "dailyLimitMet"{
                        reset(valid: false)
                        return TransitionAction(Screen: "Screen 10")
                    }
                    else{
                        reset(valid: false)
                        return TransitionAction(Screen: "Screen 9")
                    }
                }
            }
        }
        return NoAction()

    }
    
    private func produceAmount() -> String{
        var rtnString = ""
        for i in amountToBeWithdrawn{
            rtnString.append(String(i))
        }
        
        return rtnString
    }
    
    private func isValidAmount() -> Bool{
        let numAmount:Int? = Int(withdrawString)
        
        if (numAmount! % 10) != 0{
            return false
        }else if balance < Double(numAmount!){
            return false
        }else if (Double(numAmount!)+(context?.withdrawnToday)!) > dailyLimit{
            return false
        }
        
        return true
    }
    
    private func invalidReason() -> String{
        let numAmount = Int(withdrawString)
        
        if Double(numAmount!) > balance {
            print("RETURNING NOT MULTIPLE")
            return "insufficient"
        }else if (numAmount! % 10) != 0{
            return "notMultiple"
        }else{
            return "dailyLimitMet"
        }
    }
    
    private func reset(valid:Bool){
        if valid{
            self.context?.withdrawnToday += Double(withdrawString)!
            self.context?.balance -= Double(withdrawString)!
        }
        
        withdrawString = ""
        amountToBeWithdrawn = []
    
    }
    
    func attachContext(context:Context){
        self.context = context
    }
    
}
