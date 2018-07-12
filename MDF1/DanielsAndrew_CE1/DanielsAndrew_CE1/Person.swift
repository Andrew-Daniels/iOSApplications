//
//  Person.swift
//  DanielsAndrew_CE1
//
//  Created by Andrew Daniels on 1/5/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

//create a class that makes a person object
class Person {
    var name = ""
    var language = ""
    var age = 0
    var gender = ""
    var image: UIImage?
    
    init(name: String, language: String, age: Int, gender: String, image: UIImage?){
        self.name = name
        self.language = language
        self.age = age
        self.gender = gender
        
        if let actualImage = image {
            self.image = actualImage
        }
    }
}
