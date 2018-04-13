//
//  Screen2.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen13:State{
    func getLine1() -> String {
        return "Screen 13"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return "Please insert deposit"
    }
    
    func getLine4() -> String {
        return "into deposit slot."
    }
    
    func getLine5() -> String {
        return ""
    }
    
    func allowsTransition(state: State) -> Bool {
        
        if state is Screen14{
            return true
        }else if state is Screen15{
            return true
        }
        return false
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is ButtonPressedAction{
            if action.item == "DepositSlot"{
                return TransitionAction(Screen: "Screen 14")
            }
            else if action.item == "Cancel"{
                return TransitionAction(Screen: "Screen 15")
            }
        }
        return NoAction()
    }
    
    
}
