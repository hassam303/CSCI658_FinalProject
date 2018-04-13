//
//  Screen2.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen8:State{
    func getLine1() -> String {
        return "Screen 8"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return "Insufficient Funds!"
    }
    
    func getLine4() -> String {
        return "Press Enter to try"
    }
    
    func getLine5() -> String {
        return "new amount"
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
