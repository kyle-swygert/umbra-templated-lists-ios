//
//  DisplayUsableListTableViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/29/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit
import CoreData

class DisplayUsableListTableViewController: UITableViewController {

    
    var util: DataStorageUtils = DataStorageUtils()
    
    var selectedUsableList: UsableList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("the usable list view did disappear")
        
        // store the currently selected usable list into the DataModel
        // will NOT be storing a new entity in the DataModel, only updating the values for the originally stored UsableList.
        
        util.updateUsableListDataModelObjects(toUpdate: selectedUsableList)
        
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
            
            
            let currListItem = selectedUsableList.listItems[indexPath.row - 2]
            
            
            cell.displayLabel.text = selectedUsableList.listItems[indexPath.row - 2].itemText
            
            cell.checkedImageView.image = UIImage(systemName: "checkmark.square.fill")
            
            if (currListItem.isChecked == true) {
                
                cell.checkedImageView.isHidden = false
                
            } else {
                
                cell.checkedImageView.isHidden = true
                
            }
            
            break
            
            
        }

        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // when the row is selected, invert the isChecked value for the ListItem, then set the cell imageView accordingly.
        
        print("invert the bool value and set the image view accordingly.")
        
        print("current indexPath row: \(indexPath.row)")
      
        
        if (indexPath.row > 1) {

            let currCell = self.tableView.cellForRow(at: indexPath) as! UsableListCell
            let currListItem = selectedUsableList.listItems[indexPath.row - 2]
            
            //currCell.checkedImageView.image = UIImage(named: "JotaroProfile.png")
            
            currCell.checkedImageView.isHidden = !currCell.checkedImageView.isHidden
            currListItem.isChecked = !currListItem.isChecked
            
        } else {
            // title or description tapped, do not display the checked image
            
        }
        
    }

    
}
