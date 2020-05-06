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
        
        //print("GitHub button tapped")
        
        
        // follow the link to the GitHub repo when the button is tapped.
        UIApplication.shared.open(URL(string: "https://github.com/kyle-swygert/umbra-templated-lists-ios")!, options: [:], completionHandler: nil)
        
        
    }
    
    
    @IBAction func deleteAllTemplatesButtonTapped(_ sender: UIButton) {
        
        print("deleting all templates from the DataModel")
        
        // delete all of the ListTemplates from the DataModel
        let allTemplates = util.loadAllTemplatesFromDataModel()
        
        for template in allTemplates {
            util.deleteTemplateListFromDataModel(toDelete: template)
        }
        
    }
    
    
    @IBAction func deleteAllListsButtonTapped(_ sender: UIButton) {
        
        
        print("deleting all Usable Lists from the Data model")
        
        // delete all the UsableLists from the DataModel
        
        let allUsables = util.loadAllUsableListsFromDataModel()
        
        for usable in allUsables {
            util.deleteUsableListFromDataModel(toDelete: usable)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
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


}
