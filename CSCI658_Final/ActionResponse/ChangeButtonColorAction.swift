//
//  ChangeButtonColorAction.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class ChangeButtonColorAction:ActionResponse{
    var action: String
    var item: String
    var color: String?
    
    init(button:String, Color color:String) {
        self.action = "ChangeButton"
        self.item = button
        self.color = color
    }
}
