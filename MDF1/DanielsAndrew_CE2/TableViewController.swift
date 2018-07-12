//
//  TableViewController.swift
//  DanielsAndrew_CE2
//
//  Created by Andrew Daniels on 1/6/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var cellIdentifier = "Cell"
    var headerIdentifier = "CustomHeader"
    var males: [Person]?
    var females: [Person]?
    var tom = Person(name: "Tom", language: "English", age: 13, gender: "Male", image: UIImage(named: "Male"))
    var bob = Person(name: "Nguyen", language: "Vietnamese", age: 22, gender: "Male", image: UIImage(named: "Male"))
    var larry = Person(name: "Larry", language: "English", age: 22, gender: "Male", image: UIImage(named: "Male"))
    var andrew = Person(name: "Andrew", language: "English", age: 22, gender: "Male", image: UIImage(named: "Male"))
    var brandon = Person(name: "Brandon", language: "Vietnamese", age: 22, gender: "Male", image: UIImage(named: "Male"))
    var mary = Person(name: "Mary", language: "Hindi", age: 14, gender: "Female", image: UIImage(named: "Female"))
    var jessica = Person(name: "Jessica", language: "English", age: 43, gender: "Female", image: UIImage(named: "Female"))
    var jassi = Person(name: "Jassi", language: "English", age: 43, gender: "Female", image: UIImage(named: "Female"))
    var charlene = Person(name: "Charlene", language: "English", age: 43, gender: "Female", image: UIImage(named: "Female"))
    var ajla = Person(name: "Ajla", language: "English", age: 43, gender: "Female", image: UIImage(named: "Female"))
    var sections = 0
    var editingStyle: UITableViewCellEditingStyle = .delete
    var buttonTag = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        males = [tom, bob, andrew, brandon, larry]
        females = [mary, jessica, charlene, ajla, jassi]
        
        //register the CustomHeader view with an Identifier
        tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)

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

    //Check to see if there are elements inside each data model
    //Create the number of sections dependant on how many data model's are holding data
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
    
    //Check to make sure the correct rows are made editable, depending on which button was clicked by user
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let numMales = males?.count {
            if numMales == 0 {
                buttonTag = 0
            }
        }
        if indexPath.section == buttonTag {
            return true
        }
        return false
    }
    
    //return an editing style
    //editing style variable is modified from Add and Edit button IBAction's
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return editingStyle
    }
    
    //Handle the deletion or inserting of data into the tableview
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var dummySection = indexPath.section
        let alert = UIAlertController(title: "Warning", message: "Would you like to permanantly delete this item?", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
                if let numMales = self.males {
                    if indexPath.section == 0 && numMales.count > 0 {
                        self.males?.remove(at: indexPath.row)
                        if let numMales = self.males?.count {
                            if numMales == 0 {
                                tableView.deleteSections([indexPath.section], with: .left)
                                tableView.setEditing(false, animated: true)
                            } else {
                                tableView.deleteRows(at: [indexPath], with: .left)
                            }
                        }
                    } else {
                        self.females?.remove(at: indexPath.row)
                        if let numFemales = self.females?.count {
                            if numFemales == 0 {
                                tableView.deleteSections([indexPath.section], with: .left)
                                tableView.setEditing(false, animated: true)
                            } else {
                                tableView.deleteRows(at: [indexPath], with: .left)
                            }
                        }
                    }
                }
            
        })
        if editingStyle == .delete {
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        } else if editingStyle == .insert {
            if let numMales = males?.count {
                if numMales == 0 {
                    dummySection = 1
                }
            }
            if dummySection == 0 {
                self.males?.insert(self.tom, at: indexPath.row)
                tableView.insertRows(at: [indexPath], with: .right)
            }
            if dummySection == 1 {
                self.females?.insert(self.mary, at: indexPath.row)
                tableView.insertRows(at: [indexPath], with: .right)
            }
        }
        
    }

    //Create each section's custom header with labeled labels and and tagged buttons.
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! CustomHeader
        if section == 0 {
            header.label?.text = "Males"
            header.editButton.tag = section
            header.addButton.tag = section
        } else {
            header.label?.text = "Females"
            header.editButton.tag = section
            header.addButton.tag = section
        }
        
        return header
    }

    //Set the height for the custom header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61
    }
    
    //Set the amount of rows that are in each section
    //dependant on each sections respective data model count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            if let numMales = males {
                if let numFemales = females {
                if numMales.count > 0 {
                    return numMales.count
                } else if numFemales.count > 0 {
                    return numFemales.count
                    }
                }
            }
        case 1:
            if let numMales = males {
                if numMales.count > 0 {
                    if let numFemales = females {
                        return numFemales.count
                    }
                }
            }
        default:
            return 0
        }
        return 0
    }
    
    //Handles the edit button click
    //turns the editing mode on/off
    //sets the buttonTag variable
    //sets the editingStyle variable
    @IBAction func editSection(sender: UIButton) {
        if sender.title(for: .normal) == "Edit" && tableView.isEditing == false {
            editingStyle = .delete
            buttonTag = sender.tag
            tableView.setEditing(true, animated: true)
            if tableView.isEditing == true {
            sender.setTitle("Done", for: .normal)
            }
        } else if tableView.isEditing == true && buttonTag != sender.tag {
            //do nothing
        } else {
            tableView.setEditing(false, animated: true)
            sender.setTitle("Edit", for: .normal)
            buttonTag = sender.tag
        }
    }

    //Handles the add button click
    //turns the editing mode on/off
    //sets the buttonTag variable
    //sets the editingStyle variable
    @IBAction func addToSection(sender: UIButton) {
        if tableView.isEditing == true && sender.title(for: .normal) == "Done" {
            buttonTag = sender.tag
            tableView.setEditing(false, animated: true)
            sender.setTitle("Add", for: .normal)
        } else if tableView.isEditing && buttonTag != sender.tag {
            //do nothing
        } else {
        editingStyle = .insert
        buttonTag = sender.tag
        tableView.setEditing(true, animated: true)
        sender.setTitle("Done", for: .normal)
        }
    }
    
    //Sets the height for each row
    //Creates each tableviewcell
    //create each cell based off the perspective data model
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 102
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        
        switch indexPath.section {
        case 0:
            if let numMales = males {
                if numMales.count > 0 {
                    if let actualPerson = males?[indexPath.row] {
                        cell.label.text = actualPerson.name
                        cell.subLabel.text = actualPerson.language
                        if let actualImage = actualPerson.image {
                            cell.myImageView.image = actualImage
                        }
                    }
                } else if let numFemales = females {
                    if numFemales.count > 0 {
                        if let actualPerson = females?[indexPath.row] {
                            cell.label.text = actualPerson.name
                            cell.subLabel.text = actualPerson.language
                            if let actualImage = actualPerson.image {
                                cell.myImageView.image = actualImage
                            }
                        }
                    }
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
