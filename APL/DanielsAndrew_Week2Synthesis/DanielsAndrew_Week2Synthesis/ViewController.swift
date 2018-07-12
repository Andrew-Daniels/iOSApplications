//
//  ViewController.swift
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

class ViewController: UIViewController {

    //Create variables and Outlets
    @IBOutlet weak var entirePop: UITextView!
    @IBOutlet weak var northAmerica: UIButton!
    var entirePopulation: [String: Int] = [:]
    var continent: String?
    var country: String?
    var countryPopulation: Int?
    var countryInfo: [String: Int] = [:]
    var continentData: [String: [String: Int]] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Override prepare method
    //Switch checks to verify which button is clicked in order pass the correct information the second view controller
    //Passes ContinentData dictionary if there is anything there for specified continent
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newSender = sender as! UIButton
        switch newSender.tag
        {
        case 1...7:
            let sVC = segue.destination as! SecondViewController
            if newSender.tag == 1 {
                continent = "North America"
                if let passedCountryInfo = continentData[continent!]{
                sVC.countryInfo = passedCountryInfo
            }
            }
            else if newSender.tag == 2 {
                continent = "South America"
                if let passedCountryInfo = continentData[continent!]{
                sVC.countryInfo = passedCountryInfo
                }
            }
            else if newSender.tag == 3 {
                continent = "Asia"
                if let passedCountryInfo = continentData[continent!]{
                sVC.countryInfo = passedCountryInfo
                }
            }
            else if newSender.tag == 4 {
                continent = "Antarctica"
                if let passedCountryInfo = continentData[continent!]{
                    sVC.countryInfo = passedCountryInfo
                }
            }
            else if newSender.tag == 5 {
                continent = "Europe"
                if let passedCountryInfo = continentData[continent!]{
                    sVC.countryInfo = passedCountryInfo
                }
            }
            else if newSender.tag == 6 {
                continent = "Australia"
                if let passedCountryInfo = continentData[continent!]{
                    sVC.countryInfo = passedCountryInfo
                }
            }
            else if newSender.tag == 7 {
                continent = "Africa"
                if let passedCountryInfo = continentData[continent!]{
                    sVC.countryInfo = passedCountryInfo
                }
            }
            sVC.continent = continent
        default:
            print("nothing happens")
        }
    }
    
    //Create IBActions for each of the buttons
    //perform the segue and use the UIButtons tag to determine which code to execute
    @IBAction func nAmerica(_ sender: UIButton) {
        performSegue(withIdentifier: "DisplayContinentInfo", sender: sender)
    }
    @IBAction func sAmerica(_ sender: UIButton) {
        performSegue(withIdentifier: "DisplayContinentInfo", sender: sender)
    }
    @IBAction func asia(_ sender: UIButton) {
        performSegue(withIdentifier: "DisplayContinentInfo", sender: sender)
    }
    @IBAction func antarctica(_ sender: UIButton) {
        performSegue(withIdentifier: "DisplayContinentInfo", sender: sender)
    }
    @IBAction func europe(_ sender: UIButton) {
        performSegue(withIdentifier: "DisplayContinentInfo", sender: sender)
    }
    @IBAction func australia(_ sender: UIButton) {
        performSegue(withIdentifier: "DisplayContinentInfo", sender: sender)
    }
    @IBAction func africa(_ sender: UIButton) {
        performSegue(withIdentifier: "DisplayContinentInfo", sender: sender)
    }
    
    //Create unwind segue
    //Retrieve dictionary from secondviewcontroller
    //Update the entire population count
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        let sVC = segue.source as! SecondViewController
        countryInfo = sVC.countryInfo
        continent = sVC.continent
        continentData[continent!] = countryInfo
        print(continentData)
        var entirePopulationCount = 0
        if let newPop = sVC.continentPop {
            entirePopulation[continent!] = newPop
        }
        for (_, v) in entirePopulation {
            entirePopulationCount += v
        }
        entirePop.text = "Entire World's Population \n \(entirePopulationCount)"
    }
    
    
}

