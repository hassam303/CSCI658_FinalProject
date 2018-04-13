//
//  Screen2.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen9:State{
    
    func getLine1() -> String {
        return "Screen 9"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return "Machine can only"
    }
    
    func getLine4() -> String {
        return "dispense $10 notes."
    }
    
    func getLine5() -> String {
        return "Press enter to try again."
    }
    
    func allowsTransition(state: State) -> Bool {
        if state is Screen7{
            return true
        }
        return false
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is ButtonPressedAction{
            if action.item == "Enter"{
                return TransitionAction(Screen: "Screen 7")
            }
        }
        return NoAction()
    }
    
}
