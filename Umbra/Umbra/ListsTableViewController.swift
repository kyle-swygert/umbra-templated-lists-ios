//
//  ListsTableViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 3/6/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit
import CoreData

class ListsTableViewController: UITableViewController {
    
    
    
    var util: DataStorageUtils = DataStorageUtils()
    
    
    var currUsableListArr: [UsableList] = []
    
    @IBAction func newListButtonTapped(_ sender: UIButton) {
        
        // segue to a new veiw where the user will select the list that they want to instantiate. the user's selection will be returned back to this view.
        
        // after the user has selected the list to create, the list will be added to the tableView. 
        
        // make sure to cover the cases of the user selecting the list properly, or canceling the selection.
        
        
        print("newListButtonTapped()")
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "fromListsToInstantiateListView") {
            // the app will now be transferring to the view to instantiate a UsableList.
            
            // load all the ListTemplates into memory from the DataModel, then seld that data to the destination view.
            
            var templateListsArr: [ListTemplate] = []
            
            
            // TODO: retrieve the templateLists from the DataModel and display them to the screen here.
            var allTemplates = util.getTemplateItems()
            
            // for each item in the allTemplates list, get the ListItems for the specified parentID
            
            for temp in allTemplates {
                
                util.printTemplateDataObj(temp)
                
                var currList = util.templateData2TemplateObj(temp)
                
                let childrenItems = util.getListItemsForParentTemplate(temp)
                
                
                print(childrenItems)
                
                // NOTE: currently temp holds the ListTemplate object data, and the childrenItems array holds all the ListItem objects in it.
                // instantiate actual objects from these pieces of data, then add the whole ListTemplate to the templateListArr to display them on the app!
                
                for child in childrenItems {
                    // create a ListItem object from child and add it to the newly created ListTemplate object.
                    
                    var currChild = util.listItemData2ListItemObj(child)
                    
                    currList.listItems.append(currChild)
                    
                    
                }
                
                // append the newly created list from the DataModel onto the array to populate the tableView.
                
                currList.listItems = currList.listItems.sorted(by: { $0.itemOrder <= $1.itemOrder })
                
                templateListsArr.append(currList)
                
            }
            
            
            
            // prepare for the segue by setting the destination view's data to the data that was just retrieved from the DataModel.
            
            let destVC = segue.destination as! InstantiateUsableListViewController
            
            // the loaded lists are passed to the view before the class is fully loaded into the app. 
            destVC.allTemplates = templateListsArr
            
            
            
            
           
        } // end of block for first segue block.
        
        
        
        
        
    } // end of prepare()
    
    
    
    @IBAction func unwindFromInstantiateListView(sender: UIStoryboardSegue) {
        
        print("unwindFromInstantiateListView()")
        
        let prevVC = sender.source as! InstantiateUsableListViewController
        
        // get the selected list from the previous view and add a new instance of that UsableList to the tableView in this controller.
        
        print("selected ListTemplate: \(prevVC.currSelectedTemplate.templateName)")
        
        
        // now instantiate a version of this template that can be used by the user with checkBoxes and add that object to the tableView list of items.
        
        // append the new UsableList to the currUsableListArr array
        
        var newUsableList = UsableList(listTemplate: prevVC.currSelectedTemplate)
        
        
        currUsableListArr.append(newUsableList)
        
        
        // reload the tableView data after appending to the array.
        
        tableView.reloadData()
        
        
    }
    
    
    
    

} // end of class
