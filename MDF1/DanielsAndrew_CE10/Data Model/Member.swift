//
//  Member.swift
//  DanielsAndrew_CE10
//
//  Created by Andrew Daniels on 1/24/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

class Member {
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var party = ""
    var title = ""
    var stateOfR = ""
    var imageURL: URL?
    
    init(firstName: String, middleName: String, lastName: String, party: String, title: String, stateOfR: String, imageURL: URL?) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.party = party
        self.title = title
        self.stateOfR = stateOfR
        self.imageURL = imageURL
    }
}
