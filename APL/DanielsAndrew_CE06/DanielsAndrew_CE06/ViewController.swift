///
//  ViewController.swift
//  DanielsAndrew_CE06
//
//  Created by Andrew Daniels on 11/3/17.
//  Copyright © 2017 Andrew Daniels. All rights reserved.
//

/*
 Andrew Daniels
 APL-L 1711
 */

import UIKit

class ViewController: UIViewController {
    //Create variables
    //Link UIOutlets to their UIElements
    @IBOutlet weak var viewOne: UIView!
    var redColor: CGFloat?
    var greenColor: CGFloat?
    var blueColor: CGFloat?
    var backColor: UIColor?
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Override Prepare for segue function
    //Get access to SecondViewController's Variables
    //Send data from FirstViewController to SecondViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! SecondViewController
        print("Preparing for segue..")
        if let red = redColor, let green = greenColor, let blue = blueColor, let back = backColor {
        sVC.redColor = red
        sVC.greenColor = green
        sVC.blueColor = blue
        sVC.backColor = back
        }
    }
    
    //Create an Unwind Segue
    //Send data from SecondViewController to FirstViewController
    //This function will set the background color of the UIView on FVC
    //And fill in the values for Red, Green, and Blue labels.
    @IBAction func unwindToRoot(segue: UIStoryboardSegue){
        let sVC = segue.source as! SecondViewController
        print("We are unwinding..")
        
        redColor = sVC.redColor!
        greenColor = sVC.greenColor!
        blueColor = sVC.blueColor!
        backColor = sVC.backColor
        
        redLabel.text = "Red: \(redColor!)"
        greenLabel.text = "Green: \(greenColor!)"
        blueLabel.text = "Blue: \(blueColor!)"
        
        backColor = UIColor(displayP3Red: redColor!, green: greenColor!, blue: blueColor!, alpha: 1.0)
        
        viewOne.backgroundColor = backColor
        
    }

}

