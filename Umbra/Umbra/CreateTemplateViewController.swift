//
//  CreateTemplateViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/14/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit
import CoreData

class CreateTemplateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var util: DataStorageUtils = DataStorageUtils()
    
    
    var newTemplateList: ListTemplate = ListTemplate()

    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var listItemsTableView: UITableView!
    
    //var tableController: UITableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            // remove the ListItem from the array
            newTemplateList.listItems.remove(at: indexPath.row)
                    
            // Delete the row from the data source
            listItemsTableView.deleteRows(at: [indexPath], with: .fade)
            
            // dont have to remove the ListItem from the DataModel since it has not been added to it yet.
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newTemplateList.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // initialize each of the cells in the view.
        
        let cell = listItemsTableView.dequeueReusableCell(withIdentifier: "createCell", for: indexPath)
        
        
        return cell
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        // save the data in the view as a ListTemplate object, then pass it back to the ListTemplatesTableViewController.
        
        // get the title from the text field
        newTemplateList.templateName = titleTextField.text!
        
        // get the description from the text field
        newTemplateList.description = descriptionTextField.text!
        
        
        // get the listItems from the tableView. All rows should hold a list item.
        var itemCount = 0
        for cell in listItemsTableView.visibleCells as! [ListItemCell] {
            
            // set the listItem text of the current cell to the listItem text in the array with the itemCount value.
            
            newTemplateList.listItems[itemCount].itemText = cell.itemTextField.text!
            
            
            
            itemCount += 1
        }
        
        
        util.storeTemplateIntoDataModel(toStore: newTemplateList)
        
        // segue back to the TemplatesTableViewController and add this new ListTemplate to that array and display it in the tableView.
        
        performSegue(withIdentifier: "unwindFromCreateTemplate", sender: nil)
        
    }
    
    @IBAction func newListItemButtonTapped(_ sender: UIButton) {
        
        // add a new row to the tableView with a textView inside it.
        
        let currListItemsLength = newTemplateList.listItems.count
        
        //add an item to the newTemplateList.listItems array
        newTemplateList.listItems.append(ListItem(itemText: "placeHolder", itemOrder: currListItemsLength))
        
        print("Length of array: \(newTemplateList.listItems.count)")
        
        
        let indexPath = IndexPath(row: newTemplateList.listItems.count-1, section: 0)
        
        
        listItemsTableView.beginUpdates()
        listItemsTableView.insertRows(at: [indexPath], with: .fade)
        listItemsTableView.endUpdates()
        
        print("newListItemButtonTapped()")
        
    }
    

}
