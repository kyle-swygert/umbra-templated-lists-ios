//
//  ListTemplate.swift
//  Umbra
//
//  Created by Kyle Swygert on 3/6/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import Foundation

class ListTemplate {
    // this class will hold the data to create a UsableList object in the app
    
    var templateName: String // name of the template that can be selected in the app
    var id: String // unique string to identify the template. This might only ne neccessary for the instances of UsableList to differentiate themselves.
    var listItems: [String] // the strings that will be connected to checkboxes in the UsableList class
    var description: String // optional description of what the list is for
    
    // constructor / initializer for the object.
    init(templateName: String = "NewTemplate", listItems: [String] = []) {
        self.templateName = templateName
        self.id = UUID().uuidString
        self.listItems = listItems
        self.description = ""
    }
    
    
}
