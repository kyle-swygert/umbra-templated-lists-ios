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
    var listID: String
    var listItems: [ListItem]
    var description: String
    
    init(listTemplate: ListTemplate) {
        self.listName = listTemplate.templateName
        self.listID = listTemplate.templateID
        self.listItems = listTemplate.listItems
        self.description = listTemplate.description
    }
    
    
}
