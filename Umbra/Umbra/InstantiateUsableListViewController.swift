//
//  InstantiateUsableListViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 4/25/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit
import CoreData


class InstantiateUsableListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    
    
    
    
    // this picker will be populated with the names of the listTemplates that are stored in the app.
    @IBOutlet weak var templateListPicker: UIPickerView!
    
    
    // this table view will display all the information that is associated with the currently selected list that is in the picker above. display the name, description, and the list items.
    @IBOutlet weak var currTemplateTableView: UITableView!
    
    
    var allTemplates: [ListTemplate] = []
    
    
    var currSelectedTemplate: ListTemplate!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        // load all the templateLists into the program here.
        // can use the same code as the TemplateTableViewController.
        
        
        // populate the picker with the names of the templates in allTemplates.
        
        self.templateListPicker.delegate = self
        self.templateListPicker.dataSource = self
        
        self.currTemplateTableView.delegate = self
        self.currTemplateTableView.dataSource = self
        
        
        // set the currently selected ListTemplate
        // NOTE: I think that my app will only work if there is at least ione template in the app. try to see if that is the case, and if it is, attempt to fix it by not allowing the action to occur and popping up an alert saying "there are no templates to chose from.
        // default. select the first item to be the selected template.
        currSelectedTemplate = allTemplates[0]
        
        
    }
    
    // MARK: - Picker Functions.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // the picker will have the same number of rows as the number of templates in allTemplates array.
        allTemplates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // return the name of the template for that row of the picker.
        return allTemplates[row].templateName
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // the row for the picker was selected, display the contents of the description and the listItems in the tableView.
        
        print("didSelectRow()...")
        
        let count = currSelectedTemplate.listItems.count + 1
        
        currSelectedTemplate = nil
        //currTemplateTableView.reloadData()
        
        
        
        
        currTemplateTableView.beginUpdates()
        
        
        // delete all the current rows in the table
        currTemplateTableView.deleteRows(at: (0..<count).map({ (i) in IndexPath(row: i, section: 0)}), with: .fade)
        
        // set the new selected picker item then populate the table.
        currSelectedTemplate = allTemplates[row]
        
        // insert the number of rows that correspond to the new ListTemplate that is to be displayed. 
        let newCount = currSelectedTemplate.listItems.count + 1
        currTemplateTableView.insertRows(at: (0..<newCount).map({ (i) in IndexPath(row: i, section: 0)}), with: .fade)
        
        
        currTemplateTableView.endUpdates()
        
        // reload the tableView so that the new rows are loaded into the app view.
        currTemplateTableView.reloadData()
        
        
    }
    
    
    
    
    
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        
        // the template has been selected, send this information back to the previous view to create a new instance of the list.
        
        
        //var selectedTemp = self.templateListPicker.selectedRow(inComponent: 0)
        
        
        
        // trying to set the selected currSelectedTemplate object to the row that is selected in the picker in the view.
        //self.currSelectedTemplate = templateListPicker.row
        
        
    }
    
    // MARK: - TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // the currently selected template object will change depending on the item selected in the picker.
        // when the picker selection is changed, the table view will be changed to show all the items that are part of that list.
        
        
        // need to return +1 to account for the description of the list, as well as the listItems themselves.
        return currSelectedTemplate.listItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // use the DisplayTemplateCell object to show all the items in the tableView.
        
        let cell = currTemplateTableView.dequeueReusableCell(withIdentifier: "displayTemplateCell") as! DisplayTemplateCell
        
        // NOTE: For testing
        cell.displayCellLabel.text = "testing display string"
        
        // TODO: Display the actual content of the cell just like in the DisplayTemplateTableViewController
        
        // NOTE: Only display the description and the ListItems, since the name / title of the template will be in the picker view.
        
        
        if indexPath.row == 0 {
            // display the description of the list
            cell.displayCellLabel.text = currSelectedTemplate.description
            
            
        } else {
            // display that current item in the list.
            let listInd = indexPath.row - 1
            
            cell.displayCellLabel.text = currSelectedTemplate.listItems[listInd].itemText
            
        }
        
        return cell
        
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
