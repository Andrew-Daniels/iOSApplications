//
//  Flags.swift
//  DanielsAndrew_CE5
//
//  Created by Andrew Daniels on 1/13/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

class Flags {
    
    var origin: String = ""
    var flag: UIImage?
    var country: String = ""
    
    init(origin: String, flag: UIImage?, country: String) {
        self.origin = origin
        self.flag = flag
        self.country = country
    }
    
    
}
