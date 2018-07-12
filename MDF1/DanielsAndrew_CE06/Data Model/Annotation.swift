//
//  Annotation.swift
//  DanielsAndrew_CE06
//
//  Created by Andrew Daniels on 1/17/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation
import MapKit

class annotations: MKPointAnnotation {
    init(coordinate: CLLocationCoordinate2D, title: String, subTitle: String){
        super.init()
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subTitle
    }
}
