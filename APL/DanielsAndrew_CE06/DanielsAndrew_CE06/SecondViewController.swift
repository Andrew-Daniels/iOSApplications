//
//  SecondViewController.swift
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

class SecondViewController: UIViewController {

    //Create Outlets for UIElements on the View
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var secondView: UIView!
    //Create Variables for the ViewController
    var redColor: CGFloat? = 0.5
    var greenColor: CGFloat? = 0.5
    var blueColor: CGFloat? = 0.5
    var backColor: UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //When the view loads set the UIView's background color
        //Reflect what the Sliders values are.
        updateBackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Update the background color of the UIView whenever the Red Slider's value has changed.
    @IBAction func redValueChanged(_ sender: UISlider) {
        redColor = CGFloat(redSlider.value)
        updateBackColor()
    }
    //Update the background color of the UIView whenever the green Slider's value has changed.
    @IBAction func greenValueChanged(_ sender: UISlider) {
        greenColor = CGFloat(greenSlider.value)
        updateBackColor()
    }
    //Update the background color of the UIView whenever the blue Slider's value has changed.
    @IBAction func blueValueChanged(_ sender: UISlider) {
        blueColor = CGFloat(blueSlider.value)
        updateBackColor()
    }
    //Create a function that sets the UIView's background color
    func setUIViewColor(color: UIColor){
        secondView.backgroundColor = color
    }
    //Create a function that creates a UIColor
    //@arg red, green, and blue values as a CGFloat datatype.
    //@returns the new Color created
    func createBackColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        let newColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1.0)
        
        return newColor
    }
    //This function randomly creates a color for the UIView and updates it's color
    //The slider values change respectively as well
    @IBAction func randomColor(_ sender: UIButton) {
        let randomNum1 = arc4random()
        let randomNum2 = arc4random()
        let randomNum3 = arc4random()
        let randomRed = CGFloat(Double(randomNum1) / Double(INT32_MAX))
        let randomGreen = CGFloat(Double(randomNum2) / Double(INT32_MAX))
        let randomBlue = CGFloat(Double(randomNum3) / Double(INT32_MAX))
        redSlider.value = Float(randomRed)
        greenSlider.value = Float(randomGreen)
        blueSlider.value = Float(randomBlue)
        redColor = CGFloat(redSlider.value)
        greenColor = CGFloat(greenSlider.value)
        blueColor = CGFloat(blueSlider.value)
        updateBackColor()
    }
    //This function will create a color using the slider values
    //Then set the background color for the UIView
    func updateBackColor(){
        redSlider.value = Float(redColor!)
        greenSlider.value = Float(greenColor!)
        blueSlider.value = Float(blueColor!)
        backColor = createBackColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value))
        setUIViewColor(color: backColor!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
