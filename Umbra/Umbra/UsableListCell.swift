//
//  UsableListCell.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/10/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit

// TODO: I think that I want to use the FoldingCell class here for the instantiated UsableList to display all the items that are part of the cell.
// implement the app without the folding cell, then go back to make the folding cell work properly. 


class UsableListCell: UITableViewCell {

    
    // label to display the string to the cell
    
    @IBOutlet weak var displayLabel: UILabel!
    
    // custom checkbox class to display the value of isChecked variable. 
    @IBOutlet weak var checkedImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
