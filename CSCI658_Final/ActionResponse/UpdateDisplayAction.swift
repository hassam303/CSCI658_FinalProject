//
//  UpdatePinDisplayAction.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/10/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class UpdateDisplayAction:ActionResponse{
    var action: String
    var item: String
    var color: String?
    
    init(Line line:String) {
        action = "UpdateDisplay"
        item = line
    }
}
