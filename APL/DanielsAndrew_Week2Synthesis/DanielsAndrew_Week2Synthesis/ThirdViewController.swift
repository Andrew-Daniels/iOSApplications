//
//  ThirdViewController.swift
//  DanielsAndrew_Week2Synthesis
//
//  Created by Andrew Daniels on 11/6/17.
//  Copyright © 2017 Andrew Daniels. All rights reserved.
//

/*
 Andrew Daniels
 APL-L 1711
 */

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var countryName: UITextField!
    @IBOutlet weak var countryPop: UITextField!
    
    //Create variables
    var country: String?
    var countryPopulation: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //override shouldPerformSegue function
    //This function will return true and perform segue if both text fields are filled out
    //returns false if one or more text fields are left blank
    //Alerts user if there are any errors
    //Sets the variable values to what was typed in their perspective text fields
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if countryName.text?.isEmpty == false, let cPop = Int(countryPop.text!) {
            country = countryName.text!
            countryPopulation = cPop
            return true
        }
        let alert = UIAlertController(title: "Warning", message: "You cannot continue until all fields have text", preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        return false
    }
    
    //Dismiss thirdviewcontroller whenever cancel button is clicked
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
