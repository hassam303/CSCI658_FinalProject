//
//  Screen2.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen6:State{
    var context:Context?
    
    func getLine1() -> String {
        return "Screen 6"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return "Balance is"
    }
    
    func getLine4() -> String {
        return "$" + String((context?.balance)!)
    }
    
    func getLine5() -> String {
        return "Press Enter to exit"
    }
    
    func allowsTransition(state: State) -> Bool {
        if state is Screen15{
            return true
        }
        return false 
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is ButtonPressedAction{
            if action.item == "Enter"{
                return TransitionAction(Screen: "Screen 15")
            }
        }
        return NoAction()
    }
    
    func attachContext(context:Context){
        self.context = context
    }
}
