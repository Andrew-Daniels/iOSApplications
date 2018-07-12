//
//  Element.swift
//  DanielsAndrew_CE01
//
//  Created by Andrew Daniels on 3/1/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

class Element {
    
    var atomicNum: Int
    var atomicWeight: Int
    var meltingPoint: Double?
    var boilingPoint: Double?
    var yearDiscovered: Int
    var name: String
    var symbol: String
    
    init(name: String, symbol: String, atomicNumber: Int, atomicWeight: Int, meltingPoint: Double?, boilingPoint: Double?, yearDiscovered: Int) {
        self.atomicNum = atomicNumber
        self.atomicWeight = atomicWeight
        self.meltingPoint = meltingPoint
        self.boilingPoint = boilingPoint
        self.yearDiscovered = yearDiscovered
        self.name = name
        self.symbol = symbol
    }
}
