//
//  DisplayUsableListTableViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/29/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit

class DisplayUsableListTableViewController: UITableViewController {

    
    var selectedUsableList: UsableList!
    
    var checkBoxImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        checkBoxImage = UIImage(named: "checkmark.square.fill")
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        // add 2 to the count of the array to include the title of the list and the description of the list.
        return selectedUsableList.listItems.count + 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usableListCell", for: indexPath) as! UsableListCell
        
        // I think that this function is being called too many times...
        
        
        switch (indexPath.row) {
            
        case 0: // name of the list
            cell.displayLabel.text = "Title: \(selectedUsableList.listName)"
            break
            
        case 1: // description of the list
            cell.displayLabel.text = "Description: \(selectedUsableList.description)"
            break
            
            
        default: // list Items
            
            
            var currListItem = selectedUsableList.listItems[indexPath.row - 2]
            
            
            cell.displayLabel.text = selectedUsableList.listItems[indexPath.row - 2].itemText
            
            cell.checkedImageView.image = UIImage(systemName: "checkmark.square.fill")
            
            if (currListItem.isChecked == true) {
                
                cell.checkedImageView.isHidden = false
                
            } else {
                
                cell.checkedImageView.isHidden = true
                
            }
            
            
            
            //cell.checkedImageView?.image = UIImage(named: "goblin.jpeg")
            
            //cell.checkedImageView?.image = nil
            
            break
            
            
        }

        
        // this is where each cell will be initialized.
        
        // only display the imageView of the cell with a checkBox in it if the isChecked variable for that listItem is set to true.
        
        
        // TODO: Set the image view to the checkbox.
        
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // when the row is selected, invert the isChecked value for the ListItem, then set the cell imageView accordingly.
        
        print("invert the bool value and set the image view accordingly.")
        
        print("current indexPath row: \(indexPath.row)")
      
        
        if (indexPath.row > 1) {

            var currCell = self.tableView.cellForRow(at: indexPath) as! UsableListCell
            var currListItem = selectedUsableList.listItems[indexPath.row - 2]
            
            //currCell.checkedImageView.image = UIImage(named: "JotaroProfile.png")
            
            currCell.checkedImageView.isHidden = !currCell.checkedImageView.isHidden
            currListItem.isChecked = !currListItem.isChecked
            
        } else {
            
            print("title or description tapped, do not display the checked image. ")
            
        }
        
        
        
        
        
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
