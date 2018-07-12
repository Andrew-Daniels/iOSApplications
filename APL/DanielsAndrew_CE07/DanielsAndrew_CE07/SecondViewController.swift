//
//  SecondViewController.swift
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

class SecondViewController: UIViewController {
    
    //Create variables
    var arrayOfStrings: [String]?
    var strings: String?
    
    
    //Create outlets
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    @IBOutlet weak var labelSix: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call function that fills the labels with the string data from 1VC
        fillLabels()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Create IBAction function that dismisses 2VC when cancel button is clicked
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    //Create a function that reduces the array of strings to one big string
    func reduceArrayToStrings(){
        strings = arrayOfStrings?.reduce("", { x, y in
            x + " " + y
            
        })
        print(strings!)
    }
    //Create a function that fills the labels on the 2VC
    //With data from the array of strings
    func fillLabels() {
        labelOne.text = arrayOfStrings![0]
        labelTwo.text = arrayOfStrings![1]
        labelThree.text = arrayOfStrings![2]
        labelFour.text = arrayOfStrings![3]
        labelFive.text = arrayOfStrings![4]
        labelSix.text = arrayOfStrings![5]
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
