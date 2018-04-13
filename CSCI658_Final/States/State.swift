//
//  State.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

protocol State {
    func getLine1() -> String
    func getLine2() -> String
    func getLine3() -> String
    func getLine4() -> String
    func getLine5() -> String

    func allowsTransition(state:State) -> Bool
    func processAction(action:ActionResponse) -> ActionResponse
}
