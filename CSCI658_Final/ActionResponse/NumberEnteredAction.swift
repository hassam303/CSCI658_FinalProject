//
//  NumberEnteredAction.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/10/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class NumberEnteredAction:ActionResponse{
    var action: String
    var item: String
    var color: String?
    
    
    init(Number number:String){
        action = "NumberEntered"
        item = number
    }
}
