//
//  Screen2.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen11:State{    
    func getLine1() -> String {
        return "Screen 11"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return "Your balance is being"
    }
    
    func getLine4() -> String {
        return "updated. Please take"
    }
    
    func getLine5() -> String {
        return "case from dispenser."
    }
    
    func allowsTransition(state: State) -> Bool {
        if state is Screen15{
            return true
        }
        return false
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is ButtonPressedAction{
            if action.item == "CashDispenser"{
                return TransitionAction(Screen: "Screen 15")
            }
        }
        return NoAction()
    }
    
}
