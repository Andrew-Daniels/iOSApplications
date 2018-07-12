//
//  SecondViewController.swift
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

class SecondViewController: UIViewController {
    
    //Create Outlets and Variables for use throughout the viewcontroller
    @IBOutlet weak var display: UITextView!
    @IBOutlet weak var continentName: UILabel!
    var continentPop: Int?
    var continent: String?
    var country: String?
    var countryPopulation: Int?
    var countryInfo: [String : Int] = [:]
    
    //Whenever the viewcontroller is loaded
    //Change the continent name label to the correct continent name passed from previos viewcontroller
    //Display the continent's info if there is a dictionary passed from viewcontroller during segue
    override func viewDidLoad() {
        super.viewDidLoad()
        continentName.text = continent
        print(countryInfo)
        displayContinentInfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Perform the AddCountry segue when the add country button is clicked
    @IBAction func addCountry(_ sender: UIButton) {
        performSegue(withIdentifier: "AddCountry", sender: sender)
    }
    
    //Unwind segue that retreives data from the ThirdViewController
    //Get's country, and countrypopulation
    //Add's the country data to countryInfo dictionary
    //Then update's the textview to display most current continent information
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        shouldPerformSegue(withIdentifier: "unwindToSVC", sender: UIButton.self)
        let tVC = segue.source as! ThirdViewController
        country = tVC.country
        countryPopulation = tVC.countryPopulation
        countryInfo[country!] = countryPopulation!
        print(countryInfo)
        displayContinentInfo()
    }
    
    //This function will update the textview's text
    //With all of the continents country data
    func displayContinentInfo(){
        var singleCountry: String?
        var totalPopulation: Int?
        if countryInfo.count > 0 {
            let firstString = ("Total Number of Countries: \(countryInfo.count) \n")
            for(dictCountry, dictPop) in countryInfo{
                if let firstPop = totalPopulation {
                    totalPopulation = firstPop + dictPop
                }
                else {
                    totalPopulation = dictPop
                }
                if let firstCountry = singleCountry {
                    singleCountry = firstCountry + "Country: \(dictCountry) Population: \(dictPop) \n"
                }
                else{
                    singleCountry = "Country: \(dictCountry) Population: \(dictPop) \n"
                }
                
            }
            display.text = firstString + "Total Population: \(totalPopulation!) \n" + singleCountry!
            continentPop = totalPopulation
        }
        
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
