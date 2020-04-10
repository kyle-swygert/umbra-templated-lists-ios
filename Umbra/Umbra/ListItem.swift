//
//  ListItem.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/10/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import Foundation

class ListItem {
    
    var itemText: String
    var itemID: String
    var isChecked: Bool
    
    init(itemText: String, isChecked: Bool) {
        self.itemText = itemText
        self.itemID = UUID().uuidString // randomly generated string
        self.isChecked = isChecked
    }
    
    init (itemText: String) {
        self.itemText = itemText
        self.itemID = UUID().uuidString // randomly generated string
        self.isChecked = false
    }
    
    
    
}
