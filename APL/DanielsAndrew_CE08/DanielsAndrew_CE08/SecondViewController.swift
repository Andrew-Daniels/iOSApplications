//
//  SecondViewController.swift
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

class SecondViewController: UIViewController, UITextFieldDelegate {

    //Create Outlets for UI Elements
    @IBOutlet weak var firstBox: UITextField!
    @IBOutlet weak var secondBox: UITextField!
    @IBOutlet weak var thirdBox: UITextField!
    @IBOutlet weak var fourthBox: UITextField!
    @IBOutlet weak var fifthBox: UITextField!
    //Create optional TV variable
    var newTV: TV?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fill the UI textfields with the TV data
        fillBoxes()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Dismiss the keyboard whenever the view is touched.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //Call this function whenever a the next or done button is clicked on keyboard
    //Switch on the textField.tag
    //Dismiss keyboard on textField, then make next textField the firstResponder
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
        default:
            print("resignFirstResponder")
        }
        return true
    }
    //Dismiss the viewcontroller when cancel button is clicked
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    //This function fills the uitextfields with text from the newTV properties
    func fillBoxes() {
        firstBox.text = newTV?.brandName
        secondBox.text = newTV?.screenResolution
        thirdBox.text = ("\(newTV!.channel)")
        fourthBox.text = newTV?.nowPlaying
        fifthBox.text = ("\(newTV!.tvOn)")
    }
    
    //Override shouldPerformSegue function
    //Make sure all fields are properly filled in
    //Alert user if there are any errors
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if firstBox.text?.isEmpty == false, secondBox.text?.isEmpty == false, let possibleInt = Int(thirdBox.text!), fourthBox.text?.isEmpty == false, let possibleBool = Bool(fifthBox.text!) {
            newTV?.brandName = firstBox.text!
            newTV?.screenResolution = secondBox.text!
            newTV?.channel = possibleInt
            newTV?.nowPlaying = fourthBox.text!
            newTV?.tvOn = possibleBool
            return true
        }
        if firstBox.text?.isEmpty == true || secondBox.text?.isEmpty == true || fourthBox.text?.isEmpty == true {
            let alert = UIAlertController(title: "Warning", message: "You cannot continue until all fields have text", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Warning", message: "You cannot continue until the third textbox is an integer, and the fifth textbox is true or false.", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        return false
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
