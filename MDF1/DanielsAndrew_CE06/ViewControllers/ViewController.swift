//
//  ViewController.swift
//  DanielsAndrew_CE06
//
//  Created by Andrew Daniels on 1/16/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

private let identifier = "Annotation"

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //IBOutlets and Variables
    var allAnnotations: [annotations] = []
   
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var segControl: MKMapView!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    //Create the mapview
    //Request access to user's location
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        subView.layer.cornerRadius = 5
        let location = CLLocationCoordinate2D(latitude: 50, longitude: 50)
        let span = MKCoordinateSpan(latitudeDelta: 120, longitudeDelta: 120)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.region = region
        let status = CLLocationManager.authorizationStatus()
        
        if status == .denied || status == .restricted {
            //inform the user
            return
        }
        locationManager.delegate = self
        if status == .notDetermined {
            //request access
            locationManager.requestWhenInUseAuthorization()
            
        }
        
        if status == .authorizedWhenInUse || status == .authorizedWhenInUse {
            //Continue as normala
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - CLocationManager
    //Print error to console if LocationManager prompts an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    //print the location update from user to console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    //Handle the segmentIndexChanged event for the UISegmentedControl
    //Change the mapview's maptype accordingly
    @IBAction func segmentIndexChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == 0 {
            mapView.mapType = .standard
        }
        if index == 1 {
            mapView.mapType = .satellite
        }
        if index == 2 {
            mapView.mapType = .hybrid
        }
    }
    //Reanimate the annotations appearing on the board each time the view appears
    override func viewWillAppear(_ animated: Bool) {
        if allAnnotations.count > 0 && mapView.annotations.count < 2 {
            mapView.addAnnotations(allAnnotations)
        }
        //mapView.showAnnotations(allAnnotations, animated: true)
    }
    
    //MARK: - MapView
    // Dequeue the annotation views
    //return each annotationview
    //don't make the userlocation an MKAnnotationView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        view?.animatesDrop = true
        view?.canShowCallout = true
        return view
    }
    //IBAction that toggles the user's location on and off when location button is clicked
    @IBAction func toggleLocation(_ sender: UIBarButtonItem) {
        mapView.showsUserLocation = !mapView.showsUserLocation
    }
    
    //prepare for segue
    //set the switch values on the secondviewcontroller
    //dependant on whether there are annotations on the mapview
    //and whether the user's location is toggled on or off
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! SecondViewController
        if mapView.annotations.count > 1 {
            sVC.isAnnotations = true
        } else {
            sVC.isAnnotations = false
        }
        if mapView.userLocation.isUpdating {
            sVC.location = true
        } else {
            sVC.location = false
        }
    }
    
    
    
    

}

