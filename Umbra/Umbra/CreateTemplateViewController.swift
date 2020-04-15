//
//  CreateTemplateViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/14/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit

class CreateTemplateViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var listItemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        
        
        
        
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        // save the data in the view as a ListTemplate object, then pass it back to the ListTemplatesTableViewController.
        
        // get the title from the text field
        
        // get the description from the text field
        
        // get the listItems from the tableView. All rows should hold a list item. 
        
        
        print("saveButtonTapped()")
        
        
    }
    
    @IBAction func newListItemButtonTapped(_ sender: UIButton) {
        
        // add a new row to the tableView with a textView inside it. Try to make a tableViewCell that just has a textField in it as its own class so it can be reused in other parts of the project if needed.
        
        
        
        
        // TODO: Understand how to insert a new row into the table view, as well as incrementing the number of rows that are in the table view after the insertion is complete. I want this to be all automatic, allowing the user to have as many rows as they want. Don't hardcode a max number of rows value...
        // always insert the new row at the top???? Definitely have to figure this part out to correctly populate the tableView. 
        //listItemsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        
        
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
