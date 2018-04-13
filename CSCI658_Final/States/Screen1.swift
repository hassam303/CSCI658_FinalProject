//
//  Screen1.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen1:State{
    var context:Context?
    
    func getLine1() -> String {
        return "Screen 1"
    }
    
    func getLine2() -> String {
        return ""
    }
    
    func getLine3() -> String {
        return "Welcome"
    }
    
    func getLine4() -> String {
        return "please insert your"
    }
    
    func getLine5() -> String {
        return "ATM card"
    }
    
    func allowsTransition(state: State) -> Bool {
        if state is Screen2{
            return true
        }else if state is Screen4{
            return true
        }
        return false 
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is ButtonPressedAction{
            if action.item == "CardSlot"{
                if (context?.validCard)!{
                    return TransitionAction(Screen: "Screen 2")
                }
                return TransitionAction(Screen: "Screen 4")
            }
        }
        return NoAction()
    }
    
    func attachContext(context:Context){
        self.context = context
    }
    
}
