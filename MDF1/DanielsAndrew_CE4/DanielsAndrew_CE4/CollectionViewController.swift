//
//  CollectionViewController.swift
//  DanielsAndrew_CE4
//
//  Created by Andrew Daniels on 1/10/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

private let cellIdentifier = "Cell"
private let headerIdentifier = "Header"

class CollectionViewController: UICollectionViewController {
    
    //Create Variables
    var africa: [Flags]?
    var usa: [Flags]?
    var southAmerica: [Flags]?
    let egypt = Flags(origin: "Egypt", flag: UIImage(named: "Egypt"), country: "Africa")
    let ghana = Flags(origin: "Ghana", flag: UIImage(named: "Ghana"), country: "Africa")
    let kenya = Flags(origin: "Kenya", flag: UIImage(named: "Kenya"), country: "Africa")
    let libya = Flags(origin: "Libya", flag: UIImage(named: "Libya"), country: "Africa")
    let morocco = Flags(origin: "Morocco", flag: UIImage(named: "Morocco"), country: "Africa")
    let cali = Flags(origin: "California", flag: UIImage(named: "California"), country: "USA")
    let flor = Flags(origin: "Florida", flag: UIImage(named: "Florida"), country: "USA")
    let iowa = Flags(origin: "Iowa", flag: UIImage(named: "Iowa"), country: "USA")
    let tex = Flags(origin: "Texas", flag: UIImage(named: "Texas"), country: "USA")
    let wisc = Flags(origin: "Wisconsin", flag: UIImage(named: "Wisconsin"), country: "USA")
    let argen = Flags(origin: "Argentina", flag: UIImage(named: "Argentina"), country: "South America")
    let boli = Flags(origin: "Bolivia", flag: UIImage(named: "Bolivia"), country: "South America")
    let braz = Flags(origin: "Brazil", flag: UIImage(named: "Brazil"), country: "South America")
    let chile = Flags(origin: "Chile", flag: UIImage(named: "Chile"), country: "South America")
    let guyana = Flags(origin: "Guyana", flag: UIImage(named: "Guyana"), country: "South America")
    var dictOfCountryFlags: [[Flags?]]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create arrays and dictionary to hold each array
        africa = [egypt, ghana, kenya, libya, morocco]
        usa = [cali, flor, iowa, tex, wisc]
        southAmerica = [argen, boli, braz, chile, guyana]
        
        dictOfCountryFlags = [africa!, usa!, southAmerica!]
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    //Determine the number of sections based on the amount of arrays inside the dictionary
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let numSections = dictOfCountryFlags?.count {
            return numSections
        }
        
        return 0
    }

    //Determine the number of items in the section depeding on how many elements are inside each perspective array within
    //the dictionary
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataModel = dictOfCountryFlags {
            return dataModel[section].count
        }
        // #warning Incomplete implementation, return the number of items
        return 0
    }
    //Create each cell using the data model's data
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        
        if let dataModel = dictOfCountryFlags?[indexPath.section] {
            if let flag = dataModel[indexPath.row] {
                cell.textLabel?.text = flag.origin
                cell.myImageView.image = flag.flag
            }
        }
        // Configure the cell
    
        return cell
    }
    //Create the header for the collectionview
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! CollectionReusableView
        
        if let dataModel = dictOfCountryFlags?[indexPath.section] {
            if let flag = dataModel[indexPath.row] {
                header.titleLabel.text = flag.country
                header.deleteBtn.tag = indexPath.section
            }
        }
        
        
        return header
    }

    //IBAction that delete's the section whenever the button is pressed.
    @IBAction func deleteSection(_ sender: UIButton) {
        collectionView?.performBatchUpdates({
            if let _ = self.dictOfCountryFlags?[sender.tag] {
                self.dictOfCountryFlags?.remove(at: sender.tag)
            }
            self.collectionView?.deleteSections(IndexSet(integer: sender.tag))
        }, completion: { (finished) in
            self.collectionView?.reloadData()
        })
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
