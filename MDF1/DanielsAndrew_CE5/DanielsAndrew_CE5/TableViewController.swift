//
//  TableViewController.swift
//  DanielsAndrew_CE5
//
//  Created by Andrew Daniels on 1/13/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    //Create IBOutlets and Varibles
    let cellIdentifier = "Cell"
    var searchController = UISearchController(searchResultsController: nil)
    let flags = [
    Flags(origin: "Egypt", flag: UIImage(named: "Egypt"), country: "Africa"),
    Flags(origin: "Ghana", flag: UIImage(named: "Ghana"), country: "Africa"),
    Flags(origin: "Kenya", flag: UIImage(named: "Kenya"), country: "Africa"),
    Flags(origin: "Libya", flag: UIImage(named: "Libya"), country: "Africa"),
    Flags(origin: "Morocco", flag: UIImage(named: "Morocco"), country: "Africa"),
    Flags(origin: "Argentina", flag: UIImage(named: "Argentina"), country: "South America"),
    Flags(origin: "Bolivia", flag: UIImage(named: "Bolivia"), country: "South America"),
    Flags(origin: "Brazil", flag: UIImage(named: "Brazil"), country: "South America"),
    Flags(origin: "Chile", flag: UIImage(named: "Chile"), country: "South America"),
    Flags(origin: "Guyana", flag: UIImage(named: "Guyana"), country: "South America")
    ]
    var filteredFlags: [Flags] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredFlags = flags
        //setup SearchController
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        //to recieve updates
        searchController.searchResultsUpdater = self
        //setup SearchBar of SearchController
        searchController.searchBar.scopeButtonTitles = ["All", "South America", "Africa"]
        searchController.searchBar.delegate = self
        //add searchBar to the tableview
        self.searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = self.searchController.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //Create right amount of sections depending on which data we are using
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if searchController.isActive {
            if filteredFlags.count > 0 {
                return 1
            }
        }
        if flags.count > 0 {
            return 1
        }
        return 0
    }

    //Determine the number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return filteredFlags.count
        }
        return flags.count
    }
    
    //Filter through data model to set filteredFlags equal to search results
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        let scopeButtonTitles = searchController.searchBar.scopeButtonTitles!
        let selectedIndex = searchController.searchBar.selectedScopeButtonIndex
        let scopeTitle = scopeButtonTitles[selectedIndex]
        
        if scopeTitle == "All" {
        filteredFlags = flags
        }
        
        if searchText.isEmpty == false {
            filteredFlags = filteredFlags.filter({ (flags) -> Bool in
                flags.origin.lowercased().contains(searchText.lowercased())
            })
        }
        
        
        //reload data when done
        tableView.reloadData()
    }
    
    //Call this function whenever text in search bar is changed
    //Filteres through the data model to find data related to users input
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchController.searchBar.text!
        let scopeButtonTitles = searchController.searchBar.scopeButtonTitles!
        let selectedIndex = searchController.searchBar.selectedScopeButtonIndex
        let scopeTitle = scopeButtonTitles[selectedIndex]
        
        if scopeTitle == "All" {
            filteredFlags = flags
        } else {
        filteredFlags = flags.filter({ (flags) -> Bool in
            flags.country.lowercased().contains(searchController.searchBar.scopeButtonTitles![selectedIndex].lowercased())
        })
        }
        if searchText.isEmpty == false {
        filteredFlags = filteredFlags.filter({ (flags) -> Bool in
            flags.origin.lowercased().contains(searchText.lowercased())
        })
        }
        
    }

    //This function is called whenever the scope button was selected by user
    //Filter the data model based of scope selection
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if searchController.searchBar.scopeButtonTitles![selectedScope] == "All" {
            filteredFlags = flags
        } else {
        filteredFlags = flags.filter({ (flags) -> Bool in
            flags.country.lowercased().contains(searchController.searchBar.scopeButtonTitles![selectedScope].lowercased())
        })
        }
        tableView.reloadData()
    }
    
    //Create each cell using the data model
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 70
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell

        if searchController.isActive {
            cell.flagImage.image = filteredFlags[indexPath.row].flag
            cell.flagOrigin.text = filteredFlags[indexPath.row].origin
            return cell
        }
        // Configure the cell...
        cell.flagImage.image = flags[indexPath.row].flag
        cell.flagOrigin.text = flags[indexPath.row].origin

        return cell
    }
    
    //Handle the search bar's visuals whenever the cancel button is clicked.
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    //Handle the search bars visuals whenever the search bar is being edited
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        return true
    }
    //IBAction for save button
    //Sends filtered search data to the firstviewcontroller
    @IBAction func saveSearch(_ sender: UIBarButtonItem) {
        let fVC = navigationController?.viewControllers[0] as! ViewController
        for flags in filteredFlags {
            fVC.textView.text = fVC.textView.text + "Origin: \(flags.origin) Country: \(flags.country)\n"
        }
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
