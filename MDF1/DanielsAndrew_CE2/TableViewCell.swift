//
//  TableViewCell.swift
//  DanielsAndrew_CE2
//
//  Created by Andrew Daniels on 1/6/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //Create IBOutlets for the controls on the headers.
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
