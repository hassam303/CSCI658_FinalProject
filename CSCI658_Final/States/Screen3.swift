//
//  Screen1.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen3:State{
    func getLine1() -> String {
        return "Screen 3"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return ""
    }
    
    func getLine4() -> String {
        return "Your PIN is incorrect."
    }
    
    func getLine5() -> String {
        return "Press Enter to try again."
    }
    
    func allowsTransition(state: State) -> Bool {
        if state is Screen2{
            return true
        }
        return false
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is ButtonPressedAction{
            if action.item == "Enter"{
                return TransitionAction(Screen: "Screen 2")
            }
        }
        return NoAction()
    }
    
    
}
