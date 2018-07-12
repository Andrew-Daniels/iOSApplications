//
//  ViewController.swift
//  DanielsAndrew_CE05
//
//  Created by Andrew Daniels on 3/9/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//


/*
 Image URL's
 https://bit.ly/2FEdE8V
 https://bit.ly/2FwS5DN
 https://bit.ly/2DfIK1b
 https://bit.ly/2HnebJM
 https://bit.ly/2oWZ2Ig
 https://bit.ly/2DeuYfy
 https://bit.ly/2ttfIf7
 https://bit.ly/2oWmV2C
 */


import UIKit

class ViewController: UIViewController {

    //Create Variables and IBOutlets
    let images = ["https://bit.ly/2FEdE8V", "https://bit.ly/2FwS5DN", "https://bit.ly/2DfIK1b", "https://bit.ly/2HnebJM", "https://bit.ly/2oWZ2Ig", "https://bit.ly/2DeuYfy", "https://bit.ly/2ttfIf7", "https://bit.ly/2oWmV2C"]
    let serialQueue = DispatchQueue(label: "Serial")
    let concurQueue = DispatchQueue(label: "Concur", attributes: .concurrent)
    let main = DispatchQueue.main
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    
    var viewsAndImages = [(String, UIImageView)]()
    
    //Load all the images and imageViews into the array of tuples.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewsAndImages = [(images[0], imageView1), (images[1], imageView2), (images[2], imageView3), (images[3], imageView4), (images[4], imageView5), (images[5], imageView6), (images[6], imageView7), (images[7], imageView8)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //This IBAction will load all the images on the main Queue
    @IBAction func regular(_ sender: UIButton) {
        for (link, view) in viewsAndImages{
            let url = URL(string: link)
            var data = Data()
            do {
                data = try Data.init(contentsOf: url!)
            }
            catch {
                //do nothing
            }
            let image = UIImage(data: data)
            view.image = image
        }
    }
    //This IBAction clears all the images from the imageViews
    @IBAction func clear(_ sender: UIButton) {
        imageView1.image = nil
        imageView2.image = nil
        imageView3.image = nil
        imageView4.image = nil
        imageView5.image = nil
        imageView6.image = nil
        imageView7.image = nil
        imageView8.image = nil
    }
    //This IBAction will load each image to its perspective imageView in serial method
    @IBAction func serial(_ sender: UIButton) {
        for (link, view) in viewsAndImages{
            serialQueue.async {
                
                
                let url = URL(string: link)
                var data = Data()
                do {
                    data = try Data.init(contentsOf: url!)
                }
                catch {
                    //do nothing
                }
                let image = UIImage(data: data)
                self.main.async {
                    view.image = image
                }
                
            }
        }
    }
    
    //This IBAction will concurrently load the images to each imageview
    @IBAction func concurrent(_ sender: UIButton) {
        for (link, view) in viewsAndImages{
            concurQueue.async {
                
                
                let url = URL(string: link)
                var data = Data()
                do {
                    data = try Data.init(contentsOf: url!)
                }
                catch {
                    //do nothing
                }
                let image = UIImage(data: data)
                self.main.async {
                    view.image = image
                }
                
            }
        }
    }
    

}

