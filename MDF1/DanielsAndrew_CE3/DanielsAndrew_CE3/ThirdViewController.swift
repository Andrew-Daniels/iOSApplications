//
//  ThirdViewController.swift
//  DanielsAndrew_CE3
//
//  Created by Andrew Daniels on 1/9/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Pop's all controller's back to the root controller
    //when back to root button is pressed
    @IBAction func pop(_ sender: UIButton) {
        let _ = navigationController?.popToRootViewController(animated: true)
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
