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
    
    
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    
    
    var newTemplateList: ListTemplate = ListTemplate()

    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var listItemsTableView: UITableView!
    
    //var tableController: UITableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let removed = newTemplateList.listItems.remove(at: indexPath.row)
                    
            
            listItemsTableView.deleteRows(at: [indexPath], with: .fade)
            
            // TODO: remove the corresponding object from the DataModel of the app.
            
           
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newTemplateList.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // initialize each of the cells in the view.
        //let cell = listItemsTableView.dequeueReusableCell(withIdentifier: "createCell") as! ListItemCell
        
        let cell = listItemsTableView.dequeueReusableCell(withIdentifier: "createCell", for: indexPath)
        
        // TODO: add a label to the ListItemCell class.
        
        //cell.itemLabel.text = "testing"
        
        
        
        return cell
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        // save the data in the view as a ListTemplate object, then pass it back to the ListTemplatesTableViewController.
        
        
        
        print("saveButtonTapped()")
        
        
        
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
        
        
        storeTemplateIntoDataModel()
        
        // segue back to the TemplatesTableViewController and add this new ListTemplate to that array and display it in the tableView.
        
        performSegue(withIdentifier: "unwindFromCreateTemplate", sender: nil)
        
    }
    
    
    func storeTemplateIntoDataModel() {
        
        // add the items from this TemplateList object into the DataModel with CoreData for access in other parts of the app.
        
        let templateDataObj = NSEntityDescription.insertNewObject(forEntityName: "TemplateListData", into: self.managedObjectContext)
        
        let parentID = newTemplateList.templateID
        
        
        // set the title / name
        templateDataObj.setValue(newTemplateList.templateName, forKey: "templateName")
        
        // set the ID
        templateDataObj.setValue(newTemplateList.templateID, forKey: "templateID")
        
        // set the description
        templateDataObj.setValue(newTemplateList.description, forKey: "templateDescription")
        
        
        // insert the items for the current newTemplateList into the DataModel.
        
        for item in newTemplateList.listItems {
            // insert the current item into the DataModel.
            
            var currListItemDataObj = NSEntityDescription.insertNewObject(forEntityName: "ListItemData", into: self.managedObjectContext)
            
            // insert the id
            currListItemDataObj.setValue(item.itemID, forKey: "itemID")
            
            // insert the item text
            currListItemDataObj.setValue(item.itemText, forKey: "itemText")
            
            // insert the item parentID. Need to have a parent ID so we can figure out what ListItems belong to Which ListTemplates
            currListItemDataObj.setValue(parentID, forKey: "parentID")
            
            // insert the isChecked value, should be always false for now...
            currListItemDataObj.setValue(false, forKey: "isChecked")
            
            
            
        }
        
        
        appDelegate.saveContext()
        
        
    }
    
    
    
    @IBAction func newListItemButtonTapped(_ sender: UIButton) {
        
        // add a new row to the tableView with a textView inside it. Try to make a tableViewCell that just has a textField in it as its own class so it can be reused in other parts of the project if needed.
        
        
        
        
        // TODO: Understand how to insert a new row into the table view, as well as incrementing the number of rows that are in the table view after the insertion is complete. I want this to be all automatic, allowing the user to have as many rows as they want. Don't hardcode a max number of rows value...
        // always insert the new row at the top???? Definitely have to figure this part out to correctly populate the tableView. 
        //listItemsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        
        //add an item to the newTemplateList.listItems array
        newTemplateList.listItems.append(ListItem(itemText: "placeHolder"))
        
        print("Length of array: \(newTemplateList.listItems.count)")
        
        
        var indexPath = IndexPath(row: newTemplateList.listItems.count-1, section: 0)
        
        // add a new row to the table view??
        listItemsTableView.beginUpdates()
        listItemsTableView.insertRows(at: [indexPath], with: .fade)
        listItemsTableView.endUpdates()
        
        print("newListItemButtonTapped()")
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
