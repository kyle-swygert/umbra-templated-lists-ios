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
    var id: String
    var listItems: [String]
    var description: String
    
    init(listTemplate: ListTemplate) {
        self.listName = listTemplate.templateName
        self.id = UUID().uuidString
        self.listItems = listTemplate.listItems
        self.description = listTemplate.description
    }
    
    
}
