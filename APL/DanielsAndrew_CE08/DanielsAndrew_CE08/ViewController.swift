//
//  ViewController.swift
//  DanielsAndrew_CE08
//
//  Created by Andrew Daniels on 11/9/17.
//  Copyright © 2017 Andrew Daniels. All rights reserved.
//

/*
 Andrew Daniels
 APL-L 1711
 */

import UIKit

class ViewController: UIViewController {
    //Create Outlets for the UILabels
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    @IBOutlet weak var labelSix: UILabel!
    @IBOutlet weak var labelSeven: UILabel!
    //Create a variable of custom class "TV"
    let newTV = TV()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call function that fills the labels with the newTV properties
        fillLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Override the prepare function
    //Pass the TV variable to the 2VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! SecondViewController
        sVC.newTV = newTV
    }
    
    //Create a fill labels function
    //This function fills the labels with the newTV's properties
    func fillLabels(){
        labelOne.text = newTV.brandName
        labelTwo.text = newTV.screenResolution
        labelThree.text = ("\(newTV.channel)")
        labelFour.text = newTV.nowPlaying
        labelFive.text = ("TV on: \(newTV.tvOn)")
        labelSix.text = newTV.description
        labelSeven.text = newTV.info
    }
    //This IBAction turns the TV on and Off when the power button is pressed
    @IBAction func power(_ sender: Any) {
        newTV.powerOnOff()
        fillLabels()
    }
    //This IBAction changes the TV's channel to a random channel 0-100 whenever pressed
    @IBAction func randomChannel(_ sender: Any) {
        newTV.randomChannel()
        fillLabels()
    }
    //Unwind segue fills the labels with the TV's new data 
    @IBAction func unwind(segue: UIStoryboardSegue) {
        fillLabels()
    }

}

