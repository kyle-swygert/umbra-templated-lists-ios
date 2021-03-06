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
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
        tableView.rowHeight = 55
        
        
        currUsableListArr = util.loadAllUsableListsFromDataModel()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //print("The view did appear")
        
        
        currUsableListArr = util.loadAllUsableListsFromDataModel()
        
        
        // reload the data of the tableView. All the Lists may have been deleted.
        tableView.reloadData()
        
        print("ListsTableView Did Appear")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currUsableListArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayUsableCell", for: indexPath) as! DisplayTemplateCell

        
        cell.displayCellLabel.text = currUsableListArr[indexPath.row].listName
        
        return cell
    }
    
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            
            let toRemove = currUsableListArr.remove(at: indexPath.row)
            
            
            util.deleteUsableListFromDataModel(toDelete: toRemove)
            
            tableView.deleteRows(at: [indexPath], with: .fade)

            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "fromListsToInstantiateListView") {
            // the app will now be transferring to the view to instantiate a UsableList.
            
            // load all the ListTemplates into memory from the DataModel, then seld that data to the destination view.
            
            let templateListsArr: [ListTemplate] = util.loadAllTemplatesFromDataModel()
            
            
            // prepare for the segue by setting the destination view's data to the data that was just retrieved from the DataModel.
            
            let destVC = segue.destination as! InstantiateUsableListViewController
            
            // the loaded lists are passed to the view before the class is fully loaded into the app. 
            destVC.allTemplates = templateListsArr
            
        } // end of block for first segue block.
        
        else if (segue.identifier == "fromUsableListsToSingleList") {
            // the app is going to transition to the view to display the usable List with all of it's check boxes.
            
            let destVC = segue.destination as! DisplayUsableListTableViewController
            
            let currIndexPath = self.tableView.indexPathForSelectedRow
            
            destVC.selectedUsableList = currUsableListArr[currIndexPath!.row]
            
           
        }
        
        
        
        
    } // end of prepare()
    
    
    @IBAction func unwindFromDisplayUsableList(sender: UIStoryboardSegue) {
        
        
    }
    
    
    @IBAction func unwindFromInstantiateListView(sender: UIStoryboardSegue) {
        
        //print("unwindFromInstantiateListView()")
        
        let prevVC = sender.source as! InstantiateUsableListViewController
        
        // get the selected list from the previous view and add a new instance of that UsableList to the tableView in this controller.
        
        //print("selected ListTemplate: \(prevVC.currSelectedTemplate.templateName)")
        
        
        // now instantiate a version of this template that can be used by the user with checkBoxes and add that object to the tableView list of items.
        
        // append the new UsableList to the currUsableListArr array
        
        let newUsableList = UsableList(listTemplate: prevVC.currSelectedTemplate)
        
        
        // store the newly instantiated UsableList into the DataModel for use later
        util.storeUsableListIntoDataModel(toStore: newUsableList)
        
        currUsableListArr.append(newUsableList)
        
        
        // reload the tableView data after appending to the array.
        
        tableView.reloadData()
        
        
    }
    
} // end of class
