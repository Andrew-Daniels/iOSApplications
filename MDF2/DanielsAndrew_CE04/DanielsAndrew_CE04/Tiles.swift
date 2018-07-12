//
//  Tiles.swift
//  DanielsAndrew_CE04
//
//  Created by Andrew Daniels on 3/6/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

class Tile {
    var image: UIImage?
    var view: UIView?
    var imageView: UIImageView?
    
    init(image: UIImage, view: UIView, imageView: UIImageView) {
        self.image = image
        self.view = view
        self.imageView = imageView
    }
    
    func checkForMatch(image: UIImage) -> Bool {
        if image == self.image {
            return true
        }
        return false
    }
}
