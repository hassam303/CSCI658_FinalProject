//
//  Screen1.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen4:State{
    func getLine1() -> String {
        return "Screen 4"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return ""
    }
    
    func getLine4() -> String {
        return "Invalid ATM card. It will"
    }
    
    func getLine5() -> String {
        return "be retrained. Press Enter"
    }
    
    func allowsTransition(state: State) -> Bool {
        if state is Screen1{
            return true
        }
        return false
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is ButtonPressedAction{
            if action.item == "Enter"{
                return TransitionAction(Screen: "Screen 1")
            }
        }
        return NoAction()
        
        
    }
    
}
