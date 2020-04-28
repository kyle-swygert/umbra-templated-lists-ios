//
//  TemplatesTableViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 3/6/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit
import CoreData

class TemplatesTableViewController: UITableViewController {
    
    
    var templateListsArr: [ListTemplate] = []
    
    var util: DataStorageUtils = DataStorageUtils()
    
    @IBAction func newTemplateButtonTapped(_ sender: UIButton) {
        
        // segue to a new view where the user will create a new template.
        
        // when the user is finished creating the template, the ListTemplate object will be passed back to this view and added to the tableView.
        
        // make sure to account for if the user fully completes the template, or cancels the template creation.
        
        print("newTemplateButtonTapped")
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        
        
        tableView.rowHeight = 55
        
        
        // NOTE: I am adding in a hardcoded example templateList for before I implement the CoreDate Features of the app.
        
        
        /*
        //var tempTemplateList = ListTemplate(templateName: "French Toast Recipe", listItems: [], description: "My favorite French Toast Recipe that I make on the weekends. Just like Mom used to make!")
        
        var tempTemplateList = ListTemplate(templateName: "French Toast Recipe", description: "My favorite French Toast Recipe that I make on the weekends. Just like Mom used to make!", listItems: [])
        
        tempTemplateList.listItems.append(ListItem(itemText: "2 eggs"))
        tempTemplateList.listItems.append(ListItem(itemText: "2/3 cup milk"))
        tempTemplateList.listItems.append(ListItem(itemText: "1/4 tsp cinnamon"))
        tempTemplateList.listItems.append(ListItem(itemText: "1/4 tsp nutmeg"))
        tempTemplateList.listItems.append(ListItem(itemText: "1 tsp vanilla"))
        tempTemplateList.listItems.append(ListItem(itemText: "Bread"))
        
        
        templateListsArr.append(tempTemplateList)
 
        */
        
        // TODO: retrieve the templateLists from the DataModel and display them to the screen here.
        
        templateListsArr = util.loadAllTemplatesFromDataModel()
        
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return templateListsArr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTemplateCell", for: indexPath) as! ListTemplateCell
        
        // Configure the cell...
        
        var currTemplateList = templateListsArr[indexPath.row]
        
        cell.templateTitleLabel.text = currTemplateList.templateName
        
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let removed = templateListsArr.remove(at: indexPath.row)
            
            let parentID = removed.templateID
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // TODO: remove the corresponding object from the DataModel of the app.
            
            // remove the main listTemplate object from the DataModel
            
            let templateFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TemplateListData")
            
            templateFetchRequest.predicate = NSPredicate(format: "templateID == %@", parentID)
            
            var templateItemToBeRemoved: [NSManagedObject]!
            
            do {
                templateItemToBeRemoved = try util.managedObjectContext.fetch(templateFetchRequest)
            } catch {
                print("Fetching From DataModel Error: \(error)")
            }
            
            for item in templateItemToBeRemoved {
                
                print("deletion loop:")
                //printFoodItemDataObj(item)
                util.managedObjectContext.delete(item)
            }
            
            
            // remove all the ListItems from the DataModel that are associated with that main ListTemplate as well.
            
            let listItemFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListItemData")
            
            listItemFetchRequest.predicate = NSPredicate(format: "parentID == %@", parentID)
            
            var listItemToBeRemoved: [NSManagedObject]!
            
            do {
                listItemToBeRemoved = try util.managedObjectContext.fetch(listItemFetchRequest)
            } catch {
                print("Fetching From DataModel Error: \(error)")
            }
            
            for item in listItemToBeRemoved {
                
                print("deletion loop:")
                //printFoodItemDataObj(item)
                util.managedObjectContext.delete(item)
            }
            
            // save the context so that the deletions are persistant.
            util.appDelegate.saveContext()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // when the row of the tableView is selected, segue to a view that displays all datamembers in the templateList.
        // pass the whole current templateList object to the other view during a segue.
        
        
        let currTemplateList = templateListsArr[indexPath.row]
        
        // TEST: remove print later.
        print("Selected Cell: \(currTemplateList.templateName)")
        print("List Items:")
        
        var count = 0
        
        for item in currTemplateList.listItems {
            
            print("item \(count): \(item.itemText)")
            
            count += 1
        }
        
        
        // create a segue to another view and initialize the view items.
        
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    
    @IBAction func unwindFromCreateTemplateView(sender: UIStoryboardSegue) {
        // this is where the templateList object from the previous view will be stored into the data in this view.
        
        print("unwindFromCreateTemplateView()")
        
        let prevVC = sender.source as! CreateTemplateViewController
        
        let newTemplate = prevVC.newTemplateList
        
        templateListsArr.append(newTemplate)
        
        tableView.reloadData()
        
    }
    
    
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        print("sender: \(String(describing: sender))")
        
        
        if (segue.identifier == "fromListTemplatesToDisplayTemplate") {
            // get the destination of the view and set the ListTemplate as the object that was just tapped.
            
            //let cell = sender as! ListTemplateCell
            
            let currIndexPath = self.tableView.indexPathForSelectedRow
            
            
            print("segueing to display the list that was just tapped")
            
            print("index path row: \(currIndexPath!.row)")
            
            
            let dest = segue.destination as! DisplayTemplateTableViewController
            
            
            // TODO: How to get the actual cell that was just tapped on? could I get it from the sender object?
            
            
            dest.currListTemplate = templateListsArr[currIndexPath!.row]
            
            
        }
        
        
    }
    
    
}
