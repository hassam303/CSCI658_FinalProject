//
//  Screen2.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen2:State{
    
    var context:Context?
    
    var numbersEntered = 0
    var pin:[Int] = []
    
    func getLine1() -> String {
        return "Screen 2"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return ""
    }
    
    func getLine4() -> String {
        return "Please enter your PIN"
    }
    
    func getLine5() -> String {
        return produceLine5()
    }
    
    func allowsTransition(state: State) -> Bool {
        
        if state is Screen1{
            return true
        }else if state is Screen3{
            return true
        }else if state is Screen5{
            return true
        }
        
        return false
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is NumberEnteredAction{
            self.pin.append(Int(action.item)!)
            self.numbersEntered += 1;
            
            if self.numbersEntered == 4{
                if validPin(){
                    reset()
                    return TransitionAction(Screen: "Screen 5")
                }else{
                    context?.failedPinAttempts += 1
                    reset()
                    
                    if (context?.failedPinAttempts)! >= 3{
                        return TransitionAction(Screen: "Screen 1")
                    }
            
                    return TransitionAction(Screen: "Screen 3")
                }
            }
            
            return UpdateDisplayAction(Line: "Line 5")
        }
        
        return NoAction()
    }
    
    
    private func produceLine5() -> String{
        
        switch numbersEntered {
        case 1:
            return "*___"
        case 2:
            return "**__"
        case 3:
            return "***_"
        case 4:
            return "****"
        default:
            return "____"
        }
        
    }
    
    //Currently only "valid" pin is 1234
    private func validPin() -> Bool{
        for i in 1...4{
            
            if pin[i-1] != i{
                return false
            }
        }
        return true
    }
    private func reset(){
        self.pin = []
        self.numbersEntered = 0
    }
    
    func attachContext(context:Context){
        self.context = context
    }
}
