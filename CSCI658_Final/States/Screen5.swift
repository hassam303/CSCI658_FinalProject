//
//  Screen1.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class Screen5:State{
    private var context:Context!
    
    func getLine1() -> String {
        return "Screen 5"
    }
    
    func getLine2() -> String {
        return "Select transaction:"
    }
    
    func getLine3() -> String {
        return "balance >"
    }
    
    func getLine4() -> String {
        return "deposit >"
    }
    
    func getLine5() -> String {
        return "withdrawal >"
    }
    
    func allowsTransition(state: State) -> Bool {
        print("RETURING TRUE")
        
        if state is Screen2{
            return true
        }else if state is Screen6{
            return true
        }else if state is Screen7{
            return true
        }else if state is Screen12{
            return true
        }else if state is Screen13{
            return true
        }
        return false
    }
    
    func processAction(action: ActionResponse) -> ActionResponse {
        if action is ButtonPressedAction{
            if action.item == "Option1"{
                return TransitionAction(Screen: "Screen 6")
            }
            else if action.item == "Option2"{
                if context.depAllowed{
                    return TransitionAction(Screen: "Screen 13")
                }else{
                    return TransitionAction(Screen: "Screen 12")
                }
            }
            else if action.item == "Option3"{
                return TransitionAction(Screen: "Screen 7")
            }
        }
        return NoAction()
    }
    
    func attachContext(context:Context){
        self.context = context
    }
}
