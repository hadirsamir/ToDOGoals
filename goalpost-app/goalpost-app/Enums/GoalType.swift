//
//  GoalType.swift
//  goalpost-app
//
//  Created by Mac on 10/11/20.
//  Copyright © 2020 Caleb Stultz. All rights reserved.
//

import Foundation
enum GoalType : String {
    case longTerm = "Long term"
    case shortTerm = "Short term"
    func RawValue() -> String{
       return self.rawValue
    }
}

