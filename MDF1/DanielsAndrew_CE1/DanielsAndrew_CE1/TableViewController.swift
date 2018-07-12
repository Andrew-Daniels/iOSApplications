//
//  TableViewController.swift
//  DanielsAndrew_CE1
//
//  Created by Andrew Daniels on 1/5/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    var searchController = UISearchController(searchResultsController: nil)
    var cellIdentifier = "Cell"
    var males: [Person]?
    var females: [Person]?
    var tom = Person(name: "Tom", language: "English", age: 13, gender: "Male", image: UIImage(named: "Male"))
    var bob = Person(name: "Nguyen", language: "Vietnamese", age: 22, gender: "Male", image: UIImage(named: "Male"))
    var mary = Person(name: "Mary", language: "Hindi", age: 14, gender: "Female", image: UIImage(named: "Female"))
    var jessica = Person(name: "Jessica", language: "English", age: 43, gender: "Female", image: UIImage(named: "Female"))
    var sections = 0
    var selectionSection = 0
    var selectionRow = 0
    var filteredContacts: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        males = [tom, bob, tom, bob, tom]
        females = [mary, jessica, mary, jessica, mary]

        //setup SearchController
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        //to recieve updates
        searchController.searchResultsUpdater = self
        
        //setup SearchBar of SearchController
        searchController.searchBar.scopeButtonTitles = ["All", "Family", "Friend"]
        searchController.searchBar.delegate = self
        //add searchBar to the tableview
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        //what did the user type and what is the selected scope
        
        let searchText = searchController.searchBar.text!
        let scopeButtonTitles = searchController.searchBar.scopeButtonTitles!
        let selectedIndex = searchController.searchBar.selectedScopeButtonIndex
        let scopeTitle = scopeButtonTitles[selectedIndex]
        
        filteredContacts = males!
        
        //free to filter
        if searchText.isEmpty == false {
            filteredContacts = filteredContacts.filter({ (males) -> Bool in
                males.name.lowercased().contains(searchText.lowercased())
            })
        }
        
        
        //reload data when done
        tableView.reloadData()
    }
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        <#code#>
    }
    
    
    
    
    // MARK: - Table view data source

    //Define the number of sections based of the data models
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        sections = 0
        if let numMales = males {
            if numMales.count > 0 {
                sections += 1
            }
        }
        if let numFemales = females {
            if numFemales.count > 0 {
                sections += 1
            }
        }
        return sections
    }

    //Define the amount of rows per section based off the data models
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredContacts.count
        }
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            if let numMales = males {
                return numMales.count
            }
        case 1:
            if let numFemales = females {
                return numFemales.count
                }
        default:
            return 0
        }
        return 0
    }
    
    //Define the title of the each sections header based off the section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Males"
        case 1:
            return "Females"
        default:
            return "Other"
        }
    }
    
    //Establish the row height for each cell
    //Create each cell and set their values from the data model
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 73
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell

        if searchController.isActive {
            cell.label.text = filteredContacts[indexPath.row].name
            cell.subLabel.text = filteredContacts[indexPath.row].language
            if let actualImage = filteredContacts[indexPath.row].image {
                cell.myImageView.image = actualImage
            }
            return cell
        }
        switch indexPath.section {
        case 0:
            if let actualPerson = males?[indexPath.row] {
                cell.label.text = actualPerson.name
                cell.subLabel.text = actualPerson.language
                if let actualImage = actualPerson.image {
                    cell.myImageView.image = actualImage
                }
            }
        case 1:
            if let actualPerson = females?[indexPath.row] {
                cell.label.text = actualPerson.name
                cell.subLabel.text = actualPerson.language
                if let actualImage = actualPerson.image {
                    cell.myImageView.image = actualImage
                }
            }
        default:
            return cell
        }
        // Configure the cell...

        return cell
    }
    
    //Prepare for segue
    //Send data from selected cell to the detailviewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        var personData: Person?
        if let validPath = indexPath {
            if validPath.section == 0 {
                if let validMales = males {
                    personData = validMales[validPath.row]
                }
            } else {
                if let validFemales = females {
                    personData = validFemales[validPath.row]
                }
            }
        }
        let detail = segue.destination as! DetailViewController
        if let validPersonData = personData {
            detail.age = validPersonData.age
            detail.gender = validPersonData.gender
            detail.image = validPersonData.image
            detail.language = validPersonData.language
            detail.name = validPersonData.name
        }
        
    }
    //unwind from detailviewcontroller properly.
    @IBAction func backButton(segue: UIStoryboardSegue){
        //unwind
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
