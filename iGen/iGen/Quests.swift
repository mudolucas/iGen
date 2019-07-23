//
//  Quests.swift
//  iGen
//
//  Created by Lucas Mudo de Araujo on 7/19/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import Foundation

enum Frequency{
    case everyday
    case one_time_only
    case weekly
}
enum Status{
    case active
    case completed
    case expired
}

class Quests{
    
    var title:String
    var reward:Int
    var status:Status
    //var frequency:Frequency
    // Data Created
    //Data Completed
    // deadline
    
    public init(title: String, reward:String) {
        self.title = title
        self.status = .active
        let rwd = Int(reward) ?? 0
        self.reward = rwd
    }
    
}
