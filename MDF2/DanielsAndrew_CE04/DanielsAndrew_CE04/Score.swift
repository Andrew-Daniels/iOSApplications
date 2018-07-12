//
//  Score.swift
//  DanielsAndrew_CE04
//
//  Created by Andrew Daniels on 3/20/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation

//This class will be created for each score recorded
class Score {
    var name: String!
    var moves: Int!
    var time: String!
    var date: NSDate!
    
    init(name: String, moves: Int, time: String, date: NSDate) {
        self.name = name
        self.moves = moves
        self.time = time
        self.date = date
    }
    
    func formattedDate() -> String {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        let newDate = format.string(from: date as Date)
        return newDate
    }
    
    
}
