//
//  BalanceChangeAction.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/12/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

class BalanceChangeAction:ActionResponse{
    var action: String
    var item: String
    var color: String?
    
    init(NewBalance balance:Double){
        action = "BalanceChange"
        item = String(balance)
    }
    
}
