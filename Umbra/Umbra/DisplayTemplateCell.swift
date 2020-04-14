//
//  DisplayTemplateCell.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/14/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit

class DisplayTemplateCell: UITableViewCell {

    
    
    @IBOutlet weak var displayCellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
