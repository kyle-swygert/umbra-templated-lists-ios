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

    override func viewWillAppear(_ animated: Bool) {
        // set the currently selected ListTemplate
        
        if allTemplates.count > 0 {
            currSelectedTemplate = allTemplates[0]
        } else {
            
            // there are no templates in this app, dismiss this view controller and go back to the tab view.
            navigationController?.popToRootViewController(animated: true)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        self.templateListPicker.delegate = self
        self.templateListPicker.dataSource = self
        
        self.currTemplateTableView.delegate = self
        self.currTemplateTableView.dataSource = self
        
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
        
        let count = currSelectedTemplate.listItems.count + 1
        
        currSelectedTemplate = nil
       
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
        
       
    }
    
    // MARK: - TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // the currently selected template object will change depending on the item selected in the picker.
        // when the picker selection is changed, the table view will be changed to show all the items that are part of that list.
        
        if currSelectedTemplate == nil {
            return 0
        } else {
            // need to return +1 to account for the description of the list, as well as the listItems themselves.
            return currSelectedTemplate.listItems.count + 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // use the DisplayTemplateCell object to show all the items in the tableView.
        
        let cell = currTemplateTableView.dequeueReusableCell(withIdentifier: "displayTemplateCell") as! DisplayTemplateCell
        
        
        cell.displayCellLabel.text = "testing display string"
        
        
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

}
