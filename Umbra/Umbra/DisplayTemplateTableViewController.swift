//
//  DisplayTemplateTableViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/14/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit

class DisplayTemplateTableViewController: UITableViewController {

    
    var currListTemplate: ListTemplate! // set this object reference in the segue before this class is loaded in the app.
    
    
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currListTemplate.listItems.count + 2 // need to add 2 rows to the section for the title and the description of the list.
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayTemplateCell", for: indexPath) as! DisplayTemplateCell

        // Configure the cell...

        var indexRow = indexPath.row
        
        
        if indexRow == 0 {
            // list title
            cell.displayCellLabel.text = "Title: \(currListTemplate.templateName)"
        }
        
        if indexRow == 1 {
            // list description
            cell.displayCellLabel.text = "Description: \(currListTemplate.description)"
            
        }
        
        if indexRow > 1 {
            // list item
            cell.displayCellLabel.text = currListTemplate.listItems[indexPath.row-2].itemText
            
        }
        
        
        
        return cell
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
