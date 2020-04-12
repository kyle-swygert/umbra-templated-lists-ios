//
//  CreateTemplateListViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/10/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit

class CreateTemplateListViewController: UITableViewController {
    
    @IBOutlet weak var listTitleTextField: UITextField!
    
    @IBOutlet weak var listDescriptionTextField: UITextField!
    
    

    var newListItems: [ListItem] = []
    
    override func viewWillAppear(_ animated: Bool) {
        // stuff
        
        // deactivate the tabBar from this view.
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        
        
        tableView.rowHeight = 55
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // TODO: how to change the number of rows to grow with more listItems being added to the list???
        
        
        var numRows = 0
        
        switch section {
        case 0: // list title
            numRows = 1
            break
            
        case 1: // list description
            numRows = 1
            break
        
        case 2: // list items
            numRows = newListItems.count + 2 // add 1 for the cell with the button to add another row to the table
            break
        default:
            numRows = 1
        }
        
        
        return numRows
        
        //return newListItems.count
        
        //return 3
    }

    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        print("save button tapped")
        
        // create a TemplateList object from the data entered in the view, then pass the object in a segue from this view to the TemplateTableViewController.
        
    
        
        // print the title and label
        
        print("List Title:          \(listTitleTextField.text!)")
        print("List Description:    \(listDescriptionTextField.text!)")
        
        
        
        
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
        
        
        // create a TemplateList object from the data in this view, then pass that new object back to the TemplateTableViewController to then add the new TemplateList to the app DataModel.
        
        
        
        // segue back to the TemplatesTableViewController. 
        
        
        
    }
    

}
