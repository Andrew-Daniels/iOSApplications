//
//  ViewController.swift
//  DanielsAndrew_CE10
//
//  Created by Andrew Daniels on 1/23/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//
// KEY: CeR7eBoABJkT5h26o6JrvKCgOnGuDouw9D0iXSYL
// URL: https://api.propublica.org/congress/v1/{congress}/{chamber}/members.json
// Image URL: https://theunitedstates.io/images/congress/225x275/W000437.jpg

import UIKit

private let cellIdentifier = "Cell"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - IBOutlets and Variables
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var dictOfMembers: [String: [Member]] = [:]
    var arrayOfSenate: [Member] = []
    var arrayOfHouse: [Member] = []

    //MARK: - View
    
    //Request the data from the ProRepublica API
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        requestFromAPI(congress: 115, chamber: "House")
        activityIndicator.startAnimating()
        requestFromAPI(congress: 115, chamber: "Senate")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Developer Created Functions
    
    //Function that sends an HTTPRequest to API
    func requestFromAPI(congress: Int, chamber: String) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let validURL = URL(string: "https://api.propublica.org/congress/v1/\(congress)/\(chamber)/members.json") {
            var request = URLRequest(url: validURL)
            request.setValue("CeR7eBoABJkT5h26o6JrvKCgOnGuDouw9D0iXSYL", forHTTPHeaderField: "X-API-Key")
            request.httpMethod = "GET"
            let _ = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Session caused an error \(error)")
                    return
                }
                if let response = response as? HTTPURLResponse, let data = data {
                    if response.statusCode == 200 {
                        self.parseJSON(data: data, chamber: chamber)
                    }
                }
            }).resume()
        }
        
    }
    
    //Function that will create a URL optional from a unique photo identifier passed in
    func createImageURL(photoId: String) -> URL? {
        let url = URL(string: "https://theunitedstates.io/images/congress/225x275/\(photoId).jpg")
        return url
    }
    
    //Function that will parse the data passed into it
    //Retrieves the specific data needed to create member objects
    func parseJSON(data: Data, chamber: String) {
        do { let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            //print(json)
            
            if let startData = json as? [NSObject: AnyObject], let results = startData["results" as NSObject] as? [[NSObject: AnyObject]] {
                for members in results {
                    if let member = members["members" as NSObject] as? [[NSObject: AnyObject]] {
                        for oneMember in member {
                            if let firstName = oneMember["first_name" as NSObject] as? String,
                                let lastName = oneMember["last_name" as NSObject] as? String,
                                let party = oneMember["party" as NSObject] as? String,
                                let title = oneMember["title" as NSObject] as? String,
                                let state = oneMember["state" as NSObject] as? String,
                                let photoId = oneMember["id" as NSObject] as? String {
                                if let middleName = oneMember["middle_name" as NSObject] as? String {
                                    let newMember = Member(firstName: firstName, middleName: middleName, lastName: lastName, party: party, title: title, stateOfR: state, imageURL: createImageURL(photoId: photoId))
                                    if chamber == "Senate" {
                                        arrayOfSenate.append(newMember)
                                    } else {
                                        arrayOfHouse.append(newMember)
                                    }
                                } else {
                                    let newMember = Member(firstName: firstName, middleName: "", lastName: lastName, party: party, title: title, stateOfR: state, imageURL: createImageURL(photoId: photoId))
                                    if chamber == "Senate" {
                                        arrayOfSenate.append(newMember)
                                    } else {
                                        arrayOfHouse.append(newMember)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                if chamber == "Senate" {
                    self.dictOfMembers[chamber] = self.arrayOfSenate
                } else {
                    self.dictOfMembers[chamber] = self.arrayOfHouse
                }
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - UITableViewDelegate
    
    //Handles sending data to detail view controller whenever the accessory button is tapped within a cell.
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let detail = navigationController?.viewControllers[1] as! DetailViewController
        let section = indexPath.section
        let row = indexPath.row
        var key = ""
        if section == 0 {
            key = "Senate"
        } else {
            key = "House"
        }
        if let member = dictOfMembers[key]?[row] {
            if member.middleName != "" {
                detail.navTitle.title = member.firstName + " " + member.middleName + " " + member.lastName
            } else {
                detail.navTitle.title = member.firstName + " " + member.lastName
            }
            detail.partyText = member.party
            detail.stateText = member.stateOfR
            detail.titleText = member.title
            detail.imageViewURL = member.imageURL
        }
    }
    //Handles creating the cells for each row using the data model
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 80
        let section = indexPath.section
        let row = indexPath.row
        var key = ""
        if section == 0 {
            key = "Senate"
        } else {
            key = "House"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        if let member = dictOfMembers[key]?[row] {
            cell.firstName.textColor = UIColor.white
            cell.lastName.textColor = UIColor.white
            cell.memberTitle.textColor = UIColor.white
            cell.firstName.text = member.firstName
            cell.lastName.text = member.lastName
            cell.memberTitle.text = member.title
            if member.party == "R" {
                cell.backgroundColor = UIColor.red
            } else {
                cell.backgroundColor = UIColor.blue
            }
            cell.tintColor = UIColor.white
        }
        return cell
    }
    
    //Handles determining the number of rows for each section
    //by checking against the data model
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var key = ""
        if section == 0 {
            key = "Senate"
        } else {
            key = "House"
        }
        if let rows = dictOfMembers[key]?.count {
            return rows
        }
        return 0
    }
    
    //Handles creating a title for the header in each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Senate"
        } else {
            return "House"
        }
    }
    
    //Handles determining the number of sections by checking against the data model
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dictOfMembers.count
    }

}

