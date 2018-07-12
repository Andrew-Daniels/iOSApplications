//
//  DetailViewController.swift
//  DanielsAndrew_CE10
//
//  Created by Andrew Daniels on 1/24/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //IBOutlets and Variables
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var party: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var memTitle: UITextField!
    var name = ""
    var partyText = ""
    var stateText = ""
    var titleText = ""
    var imageViewURL: URL?
    
    
    //Set UIElements text properties to their perspective variables
    //Retrieve the photo from the image url supplied.
    override func viewDidLoad() {
        super.viewDidLoad()
        party.text = partyText
        state.text = stateText
        memTitle.text = titleText
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let url1 = imageViewURL {
            let _ = session.dataTask(with: url1, completionHandler: { (data, response, error) in
                //check against error
                if let error = error {
                    print("Data task failed with error: \(error)")
                    return
                }
                print("Success")
                
                //check response status
                if let http = response as? HTTPURLResponse, let data = data {
                    if http.statusCode == 200 {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.imageView.image = image
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }).resume()
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
