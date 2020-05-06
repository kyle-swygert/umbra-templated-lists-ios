//
//  TemplatesTableViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 3/6/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit
import CoreData

class TemplatesTableViewController: UITableViewController {
    
    
    var templateListsArr: [ListTemplate] = []
    
    var util: DataStorageUtils = DataStorageUtils()
    
    @IBAction func newTemplateButtonTapped(_ sender: UIButton) {
        
        // segue to a new view where the user will create a new template.
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        tableView.rowHeight = 55
        
        templateListsArr = util.loadAllTemplatesFromDataModel()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // reload the data. All the templates may have been deleted.
        
        templateListsArr = util.loadAllTemplatesFromDataModel()
        
        tableView.reloadData()
        print("TemplateTableView Did Appear")
        
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTemplateCell", for: indexPath) as! ListTemplateCell
        
        // Configure the cell...
        
        let currTemplateList = templateListsArr[indexPath.row]
        
        cell.templateTitleLabel.text = currTemplateList.templateName
        
        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let removed = templateListsArr.remove(at: indexPath.row)
            
            util.deleteTemplateListFromDataModel(toDelete: removed)
            
            //let parentID = removed.templateID
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
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
    
    
    @IBAction func unwindFromCreateTemplateView(sender: UIStoryboardSegue) {
        // this is where the templateList object from the previous view will be stored into the data in this view.
        
        print("unwindFromCreateTemplateView()")
        
        let prevVC = sender.source as! CreateTemplateViewController
        
        let newTemplate = prevVC.newTemplateList
        
        templateListsArr.append(newTemplate)
        
        tableView.reloadData()
        
    }
    
    
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        print("sender: \(String(describing: sender))")
        
        
        if (segue.identifier == "fromListTemplatesToDisplayTemplate") {
            // get the destination of the view and set the ListTemplate as the object that was just tapped.
            
            let currIndexPath = self.tableView.indexPathForSelectedRow
            
            
            print("segueing to display the list that was just tapped")
            
            print("index path row: \(currIndexPath!.row)")
            
            
            let dest = segue.destination as! DisplayTemplateTableViewController
            
            dest.currListTemplate = templateListsArr[currIndexPath!.row]
            
            
        }
        
        
    }
    
    
}
