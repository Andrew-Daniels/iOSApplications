//
//  SecondViewController.swift
//  DanielsAndrew_CE8
//
//  Created by Andrew Daniels on 1/20/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import WebKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Create IBOutlets and Variables
    @IBOutlet weak var wind: UITextField!
    @IBOutlet weak var weather: UITextField!
    @IBOutlet weak var temp: UITextField!
    let cities = ["West Des Moines", "Des Moines", "Ladora", "Adel"]
    
    // MARK: - UIPickerView
    //Return the number of components for pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //return the number of rows in each component in the pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    //return the title for each row inside the pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    //when a row is selected in the pickerview perform a JSON search with the city selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let city = cities[row].replacingOccurrences(of: " ", with: "_")
        performJSONSearch(city: city)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //function that connects to wunderground.com API
    //retrieves the JSON data
    //gets the specific data required to fill a CityWeather object
    private func performJSONSearch(city: String) {
        let config = URLSessionConfiguration.default
        
        //Create the session
        
        let session = URLSession(configuration: config)
        if let url = URL(string: "https://api.wunderground.com/api/874c07417f5929dc/conditions/q/IA/\(city).json") {
            let _ = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print("This caused an error: \(error)")
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, let data = data {
                    if httpStatus.statusCode == 200 {
                        self.parseJSON(data: data)
                    }
                    else {
                        print(httpStatus.statusCode)
                    }
                }
            }).resume()
            
        }
    }
    //This method parses data into JSON format
    //Then retrieves the data required to create a CityWeather object
    //Updates the main thread UI objects with the data
    private func parseJSON(data: Data) {
        do { let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            // Objective-C          Swift
            //NSArray               [AnyObject]
            //NSDictionary          [NSObject: AnyObject]
            let weatherVar = CityWeather()
                if let rootDictionary = json as? [NSObject: AnyObject],
                let rootData = rootDictionary["current_observation" as NSObject] as? [NSObject: AnyObject],
                let weather = rootData["weather" as NSObject] as? String,
                let windDir = rootData["wind_dir" as NSObject] as? String,
                let tempF = rootData["temp_f" as NSObject] as? Double
            {
                weatherVar.weather = weather
                weatherVar.wind = windDir
                weatherVar.tempInF = tempF
            }
            
            // UPDATE UI ON MAIN THREAD
            DispatchQueue.main.async {
                self.weather.text = weatherVar.weather
                self.wind.text = weatherVar.wind
                self.temp.text = String(weatherVar.tempInF)
            }
        }
        catch {
            print(error)
        }
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
