//
//  ViewController.swift
//  DanielsAndrew_CE07
//
//  Created by Andrew Daniels on 11/9/17.
//  Copyright © 2017 Andrew Daniels. All rights reserved.
//

/*
 Andrew Daniels
 APL-L 1711
 */

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //Create Outlets
    @IBOutlet weak var firstBox: UITextField!
    @IBOutlet weak var secondBox: UITextField!
    @IBOutlet weak var thirdBox: UITextField!
    @IBOutlet weak var fourthBox: UITextField!
    @IBOutlet weak var fifthBox: UITextField!
    @IBOutlet weak var sixthBox: UITextField!
    @IBOutlet weak var labelOne: UILabel!
    
    //create optional variable to hold strings in array
    var arrayOfStrings: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //make the firstbox become the first responder
        firstBox.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Override the touchesBegan function
    //Dismiss keyboard when the view is clicked
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //Override prepare function
    //pass the array of strings from the 1VC to the 2VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! SecondViewController
        arrayOfStrings = [firstBox.text!, secondBox.text!, thirdBox.text!, fourthBox.text!, fifthBox.text!, sixthBox.text!]
        sVC.arrayOfStrings = arrayOfStrings
    }
    
    //Override the shouldPerformSegue
    //Check to verify all fields are filled in before performing the segue
    //Alert user if a field isn't filled in
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if firstBox.text?.isEmpty == false, secondBox.text?.isEmpty == false, thirdBox.text?.isEmpty == false, fourthBox.text?.isEmpty == false, fifthBox.text?.isEmpty == false, sixthBox.text?.isEmpty == false {
            return true
        }
        //make an alertbox let user know all fields should be filled in
        let alert = UIAlertController(title: "Warning", message: "You cannot continue until all fields have text", preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        return false
    }
    //Use UITextFieldDelegate's function that call's whenever the return button is clicked
    //Check to see which textField triggers this function
    //Dismiss the keyboard then  make the next textField become the firstResponder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField.tag {
        case 1:
            secondBox.becomeFirstResponder()
        case 2:
            thirdBox.becomeFirstResponder()
        case 3:
            fourthBox.becomeFirstResponder()
        case 4:
            fifthBox.becomeFirstResponder()
        case 5:
            sixthBox.becomeFirstResponder()
        default:
            print("Nothing happened")
        }
        return true
    }
    
    //Create an unwindSegue
    //This handles reducing the array of strings into one big string
    //Set's the label on the 1VC to display the data in the string
    @IBAction func unwindReduceArray(segue: UIStoryboardSegue) {
        let sVC = segue.source as! SecondViewController
        sVC.reduceArrayToStrings()
        labelOne.text = sVC.strings!
        
    }
}


