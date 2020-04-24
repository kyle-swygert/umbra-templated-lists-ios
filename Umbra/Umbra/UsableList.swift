//
//  UsableList.swift
//  Umbra
//
//  Created by Kyle Swygert on 3/6/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import Foundation
class UsableList {
    
    var listName: String
    var listID: String // unique ID for this specific list. multiple instances of the same template can be instantiated.
    var templateID: String
    var listItems: [ListItem]
    var description: String
    
    
    // the contructor below is to create a
    init(listTemplate: ListTemplate) {
        self.listName = listTemplate.templateName
        self.listID = UUID().uuidString // generate a unique ID for this usable list when it is first created.
        self.templateID = listTemplate.templateID // the templateID for the usable list is kept track of to see which template list is needed to instantiate the list. Might have to come back to this though. I want the user to create a list from a template, delete the template, but still be able to use the instance of that list without relying on the deleted list...
        self.listItems = listTemplate.listItems
        self.description = listTemplate.description
    }
    
    
}
