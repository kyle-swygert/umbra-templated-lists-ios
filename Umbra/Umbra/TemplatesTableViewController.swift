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
    
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    
    
    
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
        
        
        
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        tableView.rowHeight = 55
        
        
        // NOTE: I am adding in a hardcoded example templateList for before I implement the CoreDate Features of the app.
        
        var tempTemplateList = ListTemplate(templateName: "French Toast Recipe", listItems: [], description: "My favorite French Toast Recipe that I make on the weekends. Just like Mom used to make!")
        
        tempTemplateList.listItems.append(ListItem(itemText: "2 eggs"))
        tempTemplateList.listItems.append(ListItem(itemText: "2/3 cup milk"))
        tempTemplateList.listItems.append(ListItem(itemText: "1/4 tsp cinnamon"))
        tempTemplateList.listItems.append(ListItem(itemText: "1/4 tsp nutmeg"))
        tempTemplateList.listItems.append(ListItem(itemText: "1 tsp vanilla"))
        tempTemplateList.listItems.append(ListItem(itemText: "Bread"))
        
        
        templateListsArr.append(tempTemplateList)
        
        
        
        
        
        // TODO: retrieve the templateLists from the DataModel and display them to the screen here.
        var allTemplates = getTemplateItems()
        
        // for each item in the allTemplates list, get the ListItems for the specified parentID
        
        for temp in allTemplates {
            
            printTemplateDataObj(temp)
            
            let childrenItems = getListItemsForParentTemplate(temp)
            
            
            print(childrenItems)
            
            // NOTE: currently temp holds the ListTemplate object data, and the childrenItems array holds all the ListItem objects in it.
            // instantiate actual objects from these pieces of data, then add the whole ListTemplate to the templateListArr to display them on the app!
            
            for child in childrenItems {
                // create a ListItem object from child and add it to the newly created ListTemplate object. 
                
                
                
            }
            
            
            
            
        }
        
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
                    
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // TODO: remove the corresponding object from the DataModel of the app.
            
           
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
