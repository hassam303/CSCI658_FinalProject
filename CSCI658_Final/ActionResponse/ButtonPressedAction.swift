//
//  ButtonPressedAction.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/10/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class ButtonPressedAction:ActionResponse{
    var action: String
    var item: String
    var color: String?
    
    init(Button bttn:String) {
        action = "ButtonPressed"
        item = bttn
    }
    
}
