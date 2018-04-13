//
//  ActionResponse.swift
//  CSCI658_Final
//
//  Created by Hassam Solano-Morel on 4/9/18.
//  Copyright © 2018 Hassam Solano-Morel. All rights reserved.
//

import Foundation

protocol ActionResponse{
    var action:String{get}
    var item:String{get}
    var color:String?{get}
}
