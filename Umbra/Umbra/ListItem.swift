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
    var itemOrder: Int  = 0 // this represents the number of item that it is in the list. This is to preserve the order of the items when they are loaded in from the DataModel. Initialize this to 0 here, but when the object is created the correct number is to be stored into the object. 
    
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
    
    
    init (itemText: String, itemOrder: Int) {
        self.itemText = itemText
        self.itemID = UUID().uuidString // randomly generated string
        self.isChecked = false
        self.itemOrder = itemOrder
    }
    
    
    // the below constructor is for building a ListItem from a DataModel object to be used in the program later.
    init (itemText: String, itemID: String) {
        self.itemText = itemText
        self.itemID = itemID
        self.isChecked = false
    }
    
    init (itemText: String, itemID: String, itemOrder: Int) {
        self.itemText = itemText
        self.itemID = itemID
        self.isChecked = false
        self.itemOrder = itemOrder
    }
    
    // constructor for loading the ListItem from the DataModel
    init(itemText: String, itemID: String, isChecked: Bool) {
        self.itemText = itemText
        self.itemID = itemID
        self.isChecked = isChecked
    }
    
    
    
}
