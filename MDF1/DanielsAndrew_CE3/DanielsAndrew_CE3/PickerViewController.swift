//
//  PickerViewController.swift
//  DanielsAndrew_CE3
//
//  Created by Andrew Daniels on 1/9/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Create IBOutlets and Variables
    @IBOutlet weak var label: UILabel!
    var labelText = ""
    @IBOutlet weak var button: UIButton!
    
    //Create and array to hold each emotion type
    let moodArray = ["Happy", "Sad", "Maudlin", "Ecstatic", "Overjoyed", "Optimistic", "Bewildered", "Cynical", "Giddy", "Indifferent", "Relaxed"]
    
    //return how many components the pickerview should have
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //return how many rows the picker should have in it's perspective component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moodArray.count
    }
    //give each row a title using the data model
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moodArray[row]
    }
    //whenever a row is selected in pickerview assign that data to the labelText variable
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        labelText = moodArray[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //assign the labelText variable to the label.text on the view controller
    //when update label button is clicked
    @IBAction func changeLabelText(_ sender: Any) {
        label.text = labelText
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
