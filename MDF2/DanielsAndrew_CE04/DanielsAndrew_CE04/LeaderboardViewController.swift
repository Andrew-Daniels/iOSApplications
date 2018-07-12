//
//  LeaderboardViewController.swift
//  DanielsAndrew_CE04
//
//  Created by Andrew Daniels on 3/19/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import CoreData

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //ManagedObjectContext - Our notepad, we write on the notepad, then save the notepad to the device
    //It's our data middleman, between our code and the harddrive.
    var managedObjectContext: NSManagedObjectContext!
    
    var leaderboard = [Score]()
    
    //This function will set the number of rows in the section of the table
    //use the count of how many scores are inside the leaderboard array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboard.count
    }
    //Set the contents for each row
    //From the data model
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 50
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.nameLabel.text = leaderboard[indexPath.row].name
        cell.dateLabel.text = leaderboard[indexPath.row].formattedDate()
        cell.movesLabel.text = leaderboard[indexPath.row].moves.description
        cell.timeLabel.text = leaderboard[indexPath.row].time
        return cell
    }
    //Apply the custom headerview to the tableview
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
        return header
    }
    //Set the height of the header in the section to 50
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //Load the managedObjects from the context into the array for the tableview later
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeader")
        // Do any additional setup after loading the view.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Leaderboard")
        do { let result = try managedObjectContext.fetch(fetchRequest)
            for obj in result {
                let newScore = Score(
                    name: obj.value(forKey: "name") as! String,
                    moves: obj.value(forKey: "moves") as! Int,
                    time: obj.value(forKey: "time") as! String,
                    date: obj.value(forKey: "date") as! NSDate)
                leaderboard.insert(newScore, at: 0)
            }
        }
        catch {
            print("Error fetching Core Data")
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
