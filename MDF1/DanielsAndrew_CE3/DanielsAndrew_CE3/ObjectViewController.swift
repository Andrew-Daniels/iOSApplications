//
//  ObjectViewController.swift
//  DanielsAndrew_CE3
//
//  Created by Andrew Daniels on 1/9/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class ObjectViewController: UIViewController {
    //Create IBOutlets and Variable
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var genderLabel: UITextField!
    @IBOutlet weak var languageLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var genderImageView: UIImageView!
    
    var person = Person(name: "Jimmy", language: "English", age: 22, gender: "Male", image: UIImage(named: "Male"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //IBAction that updates the objects member variables
    //if the data typed in by user is valid
    //whenever the update button is clicked
    @IBAction func UpdateObject(_ sender: Any) {
        if let actualName = nameLabel.text {
            person.name = actualName
        }
        if let actualGender = genderLabel.text {
            person.gender = actualGender
        }
        if let actualLanguage = languageLabel.text {
            person.language = actualLanguage
        }
        if let actualAge = Int(ageLabel.text!) {
            person.age = actualAge
        }
        if let actualImage = UIImage(named: person.gender) {
            person.image = actualImage
        }
        updateLabels()
    }
    
    //this function will update the person object with updated data input from the user
    func updateLabels() {
        nameLabel.text = person.name
        genderLabel.text = person.gender
        languageLabel.text = person.language
        ageLabel.text = String(person.age)
        genderImageView.image = person.image
        
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
