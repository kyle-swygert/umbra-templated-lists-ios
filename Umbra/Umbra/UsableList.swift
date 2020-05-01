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
    var listItems: [ListItem] = []
    var description: String
    
    
    init(listName: String, listID: String, description: String, parentTemplateID: String) {
        self.listName = listName
        self.listID = listID
        self.description = description
        self.templateID = parentTemplateID
    }
    
    
    // the contructor below is to create a UsableList from a new instance of a ListTemplate
    init(listTemplate: ListTemplate) {
        self.listName = listTemplate.templateName
        self.listID = UUID().uuidString // generate a unique ID for this usable list when it is first created.
        self.templateID = listTemplate.templateID // the templateID for the usable list is kept track of to see which template list is needed to instantiate the list. Might have to come back to this though. I want the user to create a list from a template, delete the template, but still be able to use the instance of that list without relying on the deleted list...
        
        self.description = listTemplate.description
        
        //self.listItems = listTemplate.listItems // TODO: i believe that I want to loop through all these listItems and assign them each a new itemID as to associate them with an instantiated listItem, rather than just referring to the templateListItem, meaning that the listItems in this list can keep their correct bool values for isChecked when being stored.
        
        
        for item in listTemplate.listItems {
            
            // we don't need to care about the bool for isChecked in this constructor, since this is constructing a new instance, meaning all the isChecked values will be false.
            self.listItems.append(ListItem(itemText: item.itemText, itemOrder: item.itemOrder))
            
        }
        
        
    }
    
    
    // this is a constructor for building a UsableList from the DataModel object.
    init(listTemplate: ListTemplate, listID: String) {
        self.listName = listTemplate.templateName
        self.listID = listID // set the listID to the uniquely generated string from when the UsableList was first instantiated.
        self.templateID = listTemplate.templateID // the templateID for the usable list is kept track of to see which template list is needed to instantiate the list. Might have to come back to this though. I want the user to create a list from a template, delete the template, but still be able to use the instance of that list without relying on the deleted list...
        
        self.description = listTemplate.description
        
        //self.listItems = listTemplate.listItems // TODO: i believe that I want to loop through all these listItems and assign them each a new itemID as to associate them with an instantiated listItem, rather than just referring to the templateListItem, meaning that the listItems in this list can keep their correct bool values for isChecked when being stored.
        
        
        for item in listTemplate.listItems {
            
            // we don't need to care about the bool for isChecked in this constructor, since this is constructing a new instance, meaning all the isChecked values will be false.
            //self.listItems.append(ListItem(itemText: item.itemText, itemOrder: item.itemOrder))
            
            self.listItems.append(ListItem(itemText: item.itemText, itemID: item.itemID, isChecked: item.isChecked, itemOrder: item.itemOrder))
            
        }
        
        
    }
    
    
}
