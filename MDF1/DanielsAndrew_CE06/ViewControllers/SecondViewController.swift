//
//  ViewController.swift
//  DanielsAndrew_CE06
//
//  Created by Andrew Daniels on 1/17/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import MapKit
class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Create variable to hold all annotations
    let allAnnotations = [
        annotations(coordinate: CLLocationCoordinate2D(latitude: 35, longitude: 44) , title: "Iraq", subTitle: "Asia"),
        annotations(coordinate: CLLocationCoordinate2D(latitude: -5, longitude: 14) , title: "Dominican Republic of The Congo", subTitle: "Africa"),
        annotations(coordinate: CLLocationCoordinate2D(latitude: 28.536986, longitude: -81.379564) , title: "Full Sail University", subTitle: "College Campus"),
        annotations(coordinate: CLLocationCoordinate2D(latitude: 15, longitude: 4) , title: "Niger", subTitle: "Africa"),
        annotations(coordinate: CLLocationCoordinate2D(latitude: 25, longitude: -44) , title: "North Atlantic Ocean", subTitle: "Ocean")
    ]
    //Create IBOutlets
    @IBOutlet weak var userLocationSwitch: UISwitch!
    @IBOutlet weak var annotationSwitch: UISwitch!
    
    
    var location = true
    var isAnnotations = false
    
    //MARK: - TableView
    
    //Return the number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAnnotations.count
    }
    //return each cell
    //each cell is created from the allannotation elements
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 75
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.label.text = allAnnotations[indexPath.row].title
        cell.subLabel.text = allAnnotations[indexPath.row].subtitle
        return cell
    }
    //return the title header for the section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Annotations"
    }
    //set the switches values equal to their perspective variables
    //variable data comes from segue from firstviewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        annotationSwitch.isOn = isAnnotations
        userLocationSwitch.isOn = location
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Create and IBAction that allows user to toggle annotations on/off on mapview
    @IBAction func turnOnOffAnnotations(_ sender: UISwitch) {
        let fVC = navigationController?.viewControllers[0] as! ViewController
        if sender.isOn {
        fVC.allAnnotations = allAnnotations
        } else {
        fVC.mapView.removeAnnotations(fVC.allAnnotations)
            fVC.allAnnotations = []
        }
    }
    
    //When this view is disappearing
    //Make sure to reanimate the annotations on the mapview if they are suppose to be on
    override func viewWillDisappear(_ animated: Bool) {
        //do something
        let fVC = navigationController?.viewControllers[0] as! ViewController
        if annotationSwitch.isOn {
            if fVC.mapView.annotations.count > 1 {
                fVC.mapView.removeAnnotations(fVC.allAnnotations)
                fVC.allAnnotations = []
                fVC.allAnnotations = allAnnotations
            }
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
