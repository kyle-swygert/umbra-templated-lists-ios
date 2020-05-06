//
//  SettingsTableViewController.swift
//  Umbra
//
//  Created by Kyle Swygert on 3/6/20.
//  Copyright © 2020 Kyle Swygert. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var util: DataStorageUtils = DataStorageUtils()
    
    // this label will update to the correct version of the app when the app version is changed inside the info.plist file.
    @IBOutlet weak var versionLabel: UILabel!
    

    
    @IBAction func gitHubButtonTapped(_ sender: Any) {
        // when this button is tapped, follow the link to the Github repo that is setup for the app.
        
        print("GitHub button tapped")
        
        UIApplication.shared.open(URL(string: "https://github.com/kyle-swygert/mobile-app-dev-final-project")!, options: [:], completionHandler: nil)
        
        
    }
    
    
    @IBAction func deleteAllTemplatesButtonTapped(_ sender: UIButton) {
        
        print("deleting all templates from the DataModel")
        
        // delete all of the ListTemplates from the DataModel
        var allTemplates = util.loadAllTemplatesFromDataModel()
        
        for template in allTemplates {
            util.deleteTemplateListFromDataModel(toDelete: template)
        }
        
    }
    
    
    @IBAction func deleteAllListsButtonTapped(_ sender: UIButton) {
        
        
        print("deleting all Usable Lists from the Data model")
        
        // delete all the UsableLists from the DataModel
        
        var allUsables = util.loadAllUsableListsFromDataModel()
        
        for usable in allUsables {
            util.deleteUsableListFromDataModel(toDelete: usable)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        var versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        versionLabel.text = "Version: \(versionNumber ?? "0.0")"
        
        
        self.tableView.rowHeight = 55
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
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
