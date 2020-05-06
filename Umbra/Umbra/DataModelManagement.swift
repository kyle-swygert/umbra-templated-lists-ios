//
//  DataModelManagement.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/28/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// this class will take care of all the DataModel storage management that occurs in the app to clean up the main view controller classes. As instance of this class is to be used in each of the view controllers. 
class DataStorageUtils {
    

    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    
    // TODO: add fetch requests into the DataModel to clean up this class just a bit.
    
    
    
    init() {
        
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
    }
    
    // MARK: - ListTemplate Storage
    
    func loadAllTemplatesFromDataModel() -> [ListTemplate] {
        
        
        var templateListsArr: [ListTemplate] = []
        
        
        var allTemplates = getTemplateItems()
        
        // for each item in the allTemplates list, get the ListItems for the specified parentID
        
        for temp in allTemplates {
            
            printTemplateDataObj(temp)
            
            var currList = templateData2TemplateObj(temp)
            
            let childrenItems = getListItemsForParentTemplate(temp)
            
            
            print(childrenItems)
            
            // NOTE: currently temp holds the ListTemplate object data, and the childrenItems array holds all the ListItem objects in it.
            // instantiate actual objects from these pieces of data, then add the whole ListTemplate to the templateListArr to display them on the app!
            
            for child in childrenItems {
                // create a ListItem object from child and add it to the newly created ListTemplate object.
                
                var currChild = listItemData2ListItemObj(child)
                
                currList.listItems.append(currChild)
                
                
            }
            
            // append the newly created list from the DataModel onto the array to populate the tableView.
            
            // sort the items of the list by the ItemOrder to keep the order persistant even in the DataModel
            currList.listItems = currList.listItems.sorted(by: { $0.itemOrder <= $1.itemOrder })
            templateListsArr.append(currList)
            
        }
        
        return templateListsArr
        
    }
    
    
    
    func templateData2TemplateObj(_ dataObj: NSManagedObject) -> ListTemplate {
        
        let tempName = (dataObj.value(forKey: "templateName") as? String)!
        let tempID = (dataObj.value(forKey: "templateID") as? String)!
        let tempDesc = (dataObj.value(forKey: "templateDescription") as? String)!
        
        
        return ListTemplate(templateName: tempName, description: tempDesc, listItems: [], templateID: tempID)
        
    }
    
    
    // this function will create ListItems that are to be used in the Template View, so the boolean values of the isChecked members will always be set to false. This will be different when a usable list is being created though.
    func listItemData2ListItemObj(_ dataObj: NSManagedObject) -> ListItem {
        
        let itemID = (dataObj.value(forKey: "itemID") as? String)!
        let itemText = (dataObj.value(forKey: "itemText") as? String)!
        let itemOrder = (dataObj.value(forKey: "itemOrder") as? Int)!
        
        var isChecked = (dataObj.value(forKey: "isChecked") as? Bool)
        
        
        
        if (isChecked == nil) {
            // there is some error where when a UsableList List Item is being retrieved, the isChecked value seemed to always be nil. This might be from me not setting the value correctly in the dataNodel before, and running the app with this if statement once should fix it i believe...
            
            isChecked = false
            
        }
        
        
        
        //return ListItem(itemText: itemText, itemID: itemID, itemOrder: itemOrder)
        
        
        return ListItem(itemText: itemText, itemID: itemID, isChecked: isChecked!, itemOrder: itemOrder)
        
        
    }
    
    func printTemplateDataObj(_ template: NSManagedObject) {
        
        let name = template.value(forKey: "templateName") as? String
        
        print("Current Template Name: \(name!)")
        
        
    }
    
    
    // this function will retrieve all the ListTemplate objects from the DataModel. ListItems have not been retrieved yet.
    func getTemplateItems() -> [NSManagedObject] {
        
        var allTemplates: [NSManagedObject] = []
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "TemplateListData")
        
        do {
            allTemplates = try self.managedObjectContext.fetch(fetchReq)
        } catch {
            print("getTemplateItems() error: \(error)")
        }
        
        
        return allTemplates
    }
    
    
    // this function will retrieve all the ListItems associated with the parent object that has the parentID
    func getListItemsForParentTemplate(_ parentTemplate: NSManagedObject) -> [NSManagedObject] {
        
        let parentID = parentTemplate.value(forKey: "templateID") as? String
        
        print("getListItemsForParentTemplate()")
        print("Current parentID: \(parentID!)")
        
        var allListItems: [NSManagedObject] = []
        
        // fetch the items that have the same parentID as the input parameter
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "ListItemData")
        fetchReq.predicate = NSPredicate(format: "parentID == %@", parentID!)
        
        do {
            allListItems = try self.managedObjectContext.fetch(fetchReq)
        } catch {
            print("getListItemsForParentTemplate() error: \(error)")
        }
        
        
        return allListItems
        
        
        
        
    }
    
    func storeTemplateIntoDataModel(toStore: ListTemplate) {
        
        // add the items from this TemplateList object into the DataModel with CoreData for access in other parts of the app.
        
        let templateDataObj = NSEntityDescription.insertNewObject(forEntityName: "TemplateListData", into: self.managedObjectContext)
        
        let parentID = toStore.templateID
        
        
        // set the title / name
        templateDataObj.setValue(toStore.templateName, forKey: "templateName")
        
        // set the ID
        templateDataObj.setValue(toStore.templateID, forKey: "templateID")
        
        // set the description
        templateDataObj.setValue(toStore.description, forKey: "templateDescription")
        
        
        // insert the items for the current newTemplateList into the DataModel.
        
        for item in toStore.listItems {
            // insert the current item into the DataModel.
            
            let currListItemDataObj = NSEntityDescription.insertNewObject(forEntityName: "ListItemData", into: self.managedObjectContext)
            
            // insert the id
            currListItemDataObj.setValue(item.itemID, forKey: "itemID")
            
            // insert the item text
            currListItemDataObj.setValue(item.itemText, forKey: "itemText")
            
            // insert the item parentID. Need to have a parent ID so we can figure out what ListItems belong to Which ListTemplates
            currListItemDataObj.setValue(parentID, forKey: "parentID")
            
            // insert the isChecked value, should be always false for now...
            currListItemDataObj.setValue(false, forKey: "isChecked")
            
            currListItemDataObj.setValue(item.itemOrder, forKey: "itemOrder")
            
            
        }
        
        
        appDelegate.saveContext()
        
        
    }
    
    
    // MARK: - UsableList storage
    
    
    func storeUsableListIntoDataModel(toStore: UsableList) {
        
        // this function will store the Usable list into the DataModel the first time that it is intantiated in the app.
        
        // this function will NOT be used to update the values of the
        
        
        // when storing UsableList items in this function, make sure that the parentID for the ListItemData objects is the ID string for the UsableList itself, not the ListTemplate that the UsableList was created from.
        
        
        let usableDataObj = NSEntityDescription.insertNewObject(forEntityName: "UsableListData", into: self.managedObjectContext)
        
        let parentID = toStore.listID
        
        // setting all the attributes for the UsableListData object in the DataModel
        usableDataObj.setValue(toStore.listName, forKey: "usableName")
        usableDataObj.setValue(toStore.description, forKey: "usableDescription")
        usableDataObj.setValue(toStore.listID, forKey: "usableID")
        usableDataObj.setValue(toStore.templateID, forKey: "parentTemplateID")
        
        
        
        for item in toStore.listItems {
            
            let currListItemDataObj = NSEntityDescription.insertNewObject(forEntityName: "ListItemData", into: self.managedObjectContext)
            
            // insert the id
            currListItemDataObj.setValue(item.itemID, forKey: "itemID")
            
            // insert the item text
            currListItemDataObj.setValue(item.itemText, forKey: "itemText")
            
            // insert the item parentID. Need to have a parent ID so we can figure out what ListItems belong to Which ListTemplates
            currListItemDataObj.setValue(parentID, forKey: "parentID")
            
            currListItemDataObj.setValue(item.isChecked, forKey: "isChecked")
            
            currListItemDataObj.setValue(item.itemOrder, forKey: "itemOrder")
            
            appDelegate.saveContext()
            
        }
        
        
        appDelegate.saveContext()
        
    }
    
    func getUsableListItems() -> [NSManagedObject] {
        
        // this function will retrieve all the UsableList objects stored in the DataModel
        
        var allUsableLists: [NSManagedObject] = []
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "UsableListData")
        
        do {
            allUsableLists = try self.managedObjectContext.fetch(fetchReq)
        } catch {
            print("getTemplateItems() error: \(error)")
        }
        
        return allUsableLists
    }
    
    
    func usableData2UsableObj(_ dataObj: NSManagedObject) -> UsableList {
        
        // this function will create an instance of the
        
        let tempName = (dataObj.value(forKey: "usableName") as? String)!
        let tempID = (dataObj.value(forKey: "usableID") as? String)!
        let tempDesc = (dataObj.value(forKey: "usableDescription") as? String)!
        let tempParentID = (dataObj.value(forKey: "parentTemplateID") as? String)!
        
        
        return UsableList(listName: tempName, listID: tempID, description: tempDesc, parentTemplateID: tempParentID)
    }
    
    func getListItemsForParentUsableList(_ parentTemplate: NSManagedObject) -> [NSManagedObject] {
        
        let parentID = parentTemplate.value(forKey: "usableID") as? String
        
        print("getListItemsForParentUsableList()")
        print("Current parentID: \(parentID!)")
        
        var allListItems: [NSManagedObject] = []
        
        // fetch the items that have the same parentID as the input parameter
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "ListItemData")
        fetchReq.predicate = NSPredicate(format: "parentID == %@", parentID!)
        
        do {
            allListItems = try self.managedObjectContext.fetch(fetchReq)
        } catch {
            print("getListItemsForParentTemplate() error: \(error)")
        }
        
        
        return allListItems
        
        
        
        
    }
    
    func loadAllUsableListsFromDataModel() -> [UsableList] {
        
        var usableListsArr: [UsableList] = []
        
        var allUsableObj = getUsableListItems()
        
        
        for temp in allUsableObj {
            
            var currUsable = usableData2UsableObj(temp)
            
            let childrenItems = getListItemsForParentUsableList(temp)
            
            
            for child in childrenItems {
                
                var currChild = listItemData2ListItemObj(child)
                
                currUsable.listItems.append(currChild)
                
                
            }
            
            currUsable.listItems = currUsable.listItems.sorted(by: { $0.itemOrder <= $1.itemOrder })
            
            usableListsArr.append(currUsable)
            
            
        }
        
        
        return usableListsArr
        
    }
    
    func getUsableListDataObj(toGet: UsableList) -> NSManagedObject {
        
        // this function will query the DataModel to get the Data Obj that is associated with the UsableList object that is given as input.
        
        
        var allUsableLists: [NSManagedObject] = []
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "UsableListData")
        
        fetchReq.predicate = NSPredicate(format: "usableID == %@", toGet.listID)
        
        
        do {
            allUsableLists = try self.managedObjectContext.fetch(fetchReq)
        } catch {
            print("getTemplateItems() error: \(error)")
        }
        
        // return the first item in the array, beacause there should only be one item in the list.
        return allUsableLists[0]
        
        
        
    }
    
    
    func updateUsableListDataModelObjects(toUpdate: UsableList) {
        
        print("updating the listItems for the list: \(toUpdate.listName) \(toUpdate.listID)")
        
        
        //print("NOT YET IMPLEMENTED!!!")

        // query the DataModel for the ListItems with the listID from the UsableList.
        
        
        // get the UsableList DataModel object, then we can use the getListItemsForParentUsableList() function to get the ListItems associated with the specific usableList
        
        var usableDataObj = getUsableListDataObj(toGet: toUpdate)
        
        
        var usableListItems = getListItemsForParentUsableList(usableDataObj)
        
        // iterate through the listItems in the UsableList and set the DataModel objects to the same isChecked value, then save the contex with the updated ListItems in the DataModel.
        
        
        for item in usableListItems {
            // store the new values in each of the ListItems into the DataModel.
            
            
            // get the ListItem object that is associated with teh current item
            
            var tempListItem = toUpdate.listItems.first(where: { $0.itemID == item.value(forKey: "itemID") as! String })
            
            
            
            // Should only have to set the value for the isChecked value in the ListItem Data obj
            
            item.setValue(tempListItem?.isChecked, forKey: "isChecked")
            
            appDelegate.saveContext()
            
            
        }
        
        
        // save the new upates to teh dataModel
        appDelegate.saveContext()
        
        
    }
    
    // MARK: - Deletion from DataModel
   
    func deleteListItemsFromDataModel(parentID: String) {
        
        // delete the corresponding ListItems that have the same parentID
        let listItemFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListItemData")

        listItemFetchRequest.predicate = NSPredicate(format: "parentID == %@", parentID)

        var listItemToBeRemoved: [NSManagedObject]!

        do {
            listItemToBeRemoved = try managedObjectContext.fetch(listItemFetchRequest)
        } catch {
            print("Fetching From DataModel Error: \(error)")
        }

        for item in listItemToBeRemoved {

            print("deletion loop:")
            //printFoodItemDataObj(item)
            managedObjectContext.delete(item)
        }

        // save the context so that the deletions are persistant.
        appDelegate.saveContext()
        
        
    }
    
    
    func deleteUsableListFromDataModel(toDelete: UsableList) {
        // this function will remove the UsableList, as well as all of its ListItems from the DataModel
        
        let parentID = toDelete.listID
        
        let usableFetchReq = NSFetchRequest<NSManagedObject>(entityName: "UsableListData")
        
        usableFetchReq.predicate = NSPredicate(format: "usableID == %@", parentID)
        
        var usableItemToBeRemove: [NSManagedObject]!
        
        do {
            usableItemToBeRemove = try managedObjectContext.fetch(usableFetchReq)
        } catch {
            print("Fetching From DataModel Error: \(error)")
        }
        
        
        for item in usableItemToBeRemove {
            
            print("deleting usableList")
            
            managedObjectContext.delete(item)
            
        }
        
        deleteListItemsFromDataModel(parentID: parentID)
        

        // save the context so that the deletions are persistant.
        appDelegate.saveContext()
        
    }
    
    func deleteTemplateListFromDataModel(toDelete: ListTemplate) {
        // this function will remove the ListTemplate, as well as all of its ListItems from the DataModel
        
        let parentID = toDelete.templateID
        
        // remove the main listTemplate object from the DataModel
        
        let templateFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TemplateListData")
        
        templateFetchRequest.predicate = NSPredicate(format: "templateID == %@", parentID)
        
        var templateItemToBeRemoved: [NSManagedObject]!
        
        do {
            templateItemToBeRemoved = try managedObjectContext.fetch(templateFetchRequest)
        } catch {
            print("Fetching From DataModel Error: \(error)")
        }
        
        for item in templateItemToBeRemoved {
            
            print("deletion loop:")
            //printFoodItemDataObj(item)
            managedObjectContext.delete(item)
        }
        
        
        // remove all the ListItems from the DataModel that are associated with that main ListTemplate as well.
        
        deleteListItemsFromDataModel(parentID: parentID)
        
        // save the context so that the deletions are persistant.
        appDelegate.saveContext()
        
        
    }
    
    
    
}
