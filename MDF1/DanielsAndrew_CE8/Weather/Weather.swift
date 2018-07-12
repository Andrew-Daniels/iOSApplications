//
//  Weather.swift
//  DanielsAndrew_CE8
//
//  Created by Andrew Daniels on 1/21/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation

class CityWeather {
    var weather = ""
    var wind = ""
    var tempInF = 0.00
    init() {
        
    }
    init(weather: String, wind: String, tempInF: Double) {
        self.weather = weather
        self.wind = wind
        self.tempInF = tempInF
    }
}
