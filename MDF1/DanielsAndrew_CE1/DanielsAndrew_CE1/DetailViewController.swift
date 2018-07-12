//
//  DetailViewController.swift
//  DanielsAndrew_CE1
//
//  Created by Andrew Daniels on 1/5/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //create IBOutlets for the controls on detailviewcontroller
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    //set variables for the data
    var gender: String?
    var language: String?
    var age: Int?
    var name: String?
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //transfer data from variables to their respective UIElements
        if let g = gender, let l = language, let a = age, let n = name, let i = image {
            genderLabel.text = g
            languageLabel.text = l
            ageLabel.text = String(a)
            nameLabel.text = n
            myImageView.image = i
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
