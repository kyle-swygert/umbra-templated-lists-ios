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

        let indexRow = indexPath.row
        
        
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
    

}
