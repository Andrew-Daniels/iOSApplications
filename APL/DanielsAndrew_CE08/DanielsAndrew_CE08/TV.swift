//
//  TV.swift
//  DanielsAndrew_CE08
//
//  Created by Andrew Daniels on 11/9/17.
//  Copyright © 2017 Andrew Daniels. All rights reserved.
//

/*
 Andrew Daniels
 APL-L 1711
 */

import Foundation

//Create custom TV class
class TV {
    //Set properties to default values
    var tvOn = true
    var nowPlaying = "War of the Ghosts"
    var channel = 5
    var brandName = "Samsung"
    var screenResolution = "3840x2860"
    
    //create computed property
    //return a description that describes the TV's current state
    var description: String {
        get{
            if tvOn == true {
            let desc = "You are watching \(nowPlaying) on channel \(channel)"
            return desc
            }
            else {
                let desc = "Your TV is off, there isn't anything playing"
                return desc
            }
        }
    }
    //create an instance property
    //return the a string that represents the TV's information
    var info: String {
        let info = "Brand: \(brandName) Screen Resolution: \(screenResolution)"
        return info
    }
    //create a default initializer
    init(){
        
    }
    //create an initializer that takes in arguments
    //allow for creating a custom TV object
    init(tvOn: Bool, nowPlaying: String, channel: Int, brandName: String, screenResolution: String){
        self.tvOn = tvOn
        self.nowPlaying = nowPlaying
        self.channel = channel
        self.brandName = brandName
        self.screenResolution = screenResolution
    }
    
    //create a function that turns the TV on and off
    func powerOnOff(){
        tvOn = !tvOn
    }
    //create a function that changes the channel to a channel between 0 and 100
    func randomChannel(){
        let rand = arc4random()
        channel = Int(Double(rand) * 100 / Double(UINT32_MAX))
    }
    
}
