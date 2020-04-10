//
//  TemplatesTableViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 3/6/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit

class TemplatesTableViewController: UITableViewController {

    
    var templateListsArr: [ListTemplate] = []
    
    
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
        
        
        // NOTE: I am adding in a hardcoded example templateList for before I implement the CoreDate Features of the app.
        
        var tempTemplateList = ListTemplate(templateName: "French Toast Recipe", listItems: [], description: "My favorite French Toast Recipe that I make on the weekends. Just like Mom used to make!")
        
        tempTemplateList.listItems.append(ListItem(itemText: "2 eggs"))
        tempTemplateList.listItems.append(ListItem(itemText: "2/3 cup milk"))
        tempTemplateList.listItems.append(ListItem(itemText: "1/4 tsp cinnamon"))
        tempTemplateList.listItems.append(ListItem(itemText: "1/4 tsp nutmeg"))
        tempTemplateList.listItems.append(ListItem(itemText: "1 tsp vanilla"))
        tempTemplateList.listItems.append(ListItem(itemText: "Bread"))
        
        
        templateListsArr.append(tempTemplateList)
        
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
