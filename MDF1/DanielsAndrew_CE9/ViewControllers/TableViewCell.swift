//
//  TableViewCell.swift
//  DanielsAndrew_CE9
//
//  Created by Andrew Daniels on 1/23/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
