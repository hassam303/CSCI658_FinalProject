//
//  Screen2.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen14:State{
    func getLine1() -> String {
        return "Screen 14"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return "Your new balance is"
    }
    
    func getLine4() -> String {
        return "being printed. Another"
    }
    
    func getLine5() -> String {
        return "transation?"
    }
    
    func allowsTransition(state: State) -> Bool {
        if state is Screen5{
            return true
        }else if state is Screen15{
            return true
        }
        return false
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is ButtonPressedAction{
            if action.item == "Enter"{
                return TransitionAction(Screen: "Screen 5")
            }
            else if action.item == "Cancel"{
                return TransitionAction(Screen: "Screen 15")
            }
        }
        return NoAction()
    }
    
    
}
