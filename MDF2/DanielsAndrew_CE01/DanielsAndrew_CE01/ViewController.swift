//
//  ViewController.swift
//  DanielsAndrew_CE01
//
//  Created by Andrew Daniels on 2/28/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var elements: [Element]?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var atomicNumber: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var atomicWeight: UILabel!
    @IBOutlet weak var yearDiscovered: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let elements = elements {
            return elements.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.tag = indexPath.row
        if let elements = elements {
            cell.nameLabel.text = elements[cell.tag].name
            cell.symbolLabel.text = elements[cell.tag].symbol
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = indexPath.row
        if let element = elements?[tag] {
            atomicNumber.text = String(element.atomicNum)
            atomicWeight.text = String(element.atomicWeight)
            yearDiscovered.text = String(element.yearDiscovered)
            name.text = String(element.name)
            symbol.text = String(element.symbol)
            if let melt = element.meltingPoint {
                meltingPoint.text = String(melt)
            } else {meltingPoint.text = "N/A"}
            if let boil = element.boilingPoint {
                boilingPoint.text = String(boil)
            } else {boilingPoint.text = "N/A"}
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        elements = [
            Element(name: "Plutonium", symbol: "Pu", atomicNumber: 94, atomicWeight: 244, meltingPoint: 912.5, boilingPoint: 3505, yearDiscovered: 1940),
            Element(name: "Uranium", symbol: "U", atomicNumber: 92, atomicWeight: 238, meltingPoint: 1405.3, boilingPoint: 4404, yearDiscovered: 1789),
            Element(name: "Promethium", symbol: "Pm", atomicNumber: 61, atomicWeight: 145, meltingPoint: 1315, boilingPoint: 3273, yearDiscovered: 1945),
            Element(name: "Radon", symbol: "Rn", atomicNumber: 86, atomicWeight: 222, meltingPoint: 202, boilingPoint: 211.5, yearDiscovered: 1900),
            Element(name: "Thorium", symbol: "Th", atomicNumber: 90, atomicWeight: 232, meltingPoint: 2023, boilingPoint: 5061, yearDiscovered: 1829),
            Element(name: "Radium", symbol: "Ra", atomicNumber: 88, atomicWeight: 226, meltingPoint: 973, boilingPoint: 2010, yearDiscovered: 1898),
            Element(name: "Protactinium", symbol: "Pa", atomicNumber: 91, atomicWeight: 231, meltingPoint: 1600, boilingPoint: nil, yearDiscovered: 1913)
        ]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

