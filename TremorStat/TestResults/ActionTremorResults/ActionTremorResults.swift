//
//  ActionTremorResults
//  TremorStat
//
//  Created by Best Software on 11/10/17.
//  Copyright © 2017 Best Software. All rights reserved.
//
//

import UIKit
import SafariServices

class ActionTremorResults: UIViewController, UITextFieldDelegate {
    
    // Array that stores all Action Tremor Test results
    var actionTremorResultArray = [[Double]]()
    
    var numOfRow = 0
    
    @IBOutlet weak var addVideoTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // Store previous Action Tremor Test results in the array
        self.actionTremorResultArray = getDataFromKey(key: "actionTremorResultArray")
        
        // Reverse the array so that latest test results are processed first
        actionTremorResultArray=actionTremorResultArray.reversed()
        
        //Update table view
        tableView.reloadData()
    }

    // Segue for passing particular test results to ActionTremorResultsDescription view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass the results for picked tast to the Description page view to show information about it
        let nextController = segue.destination as! ActionTremorResultsDescription
        nextController.results = actionTremorResultArray[numOfRow]
    }
}

extension ActionTremorResults: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Store previous Action Tremor Test results in the array
        return actionTremorResultArray.count
    }
    
    
    // Function printing all Action Tremor Results in a table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Code below transforms a Date type in a readable format
        var dateString = Date(timeIntervalSince1970:(actionTremorResultArray[indexPath.row])[0])
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let mystring = dateFormatter.string(from: dateString);
        let yourDate: Date? = dateFormatter.date(from: mystring)
        dateFormatter.dateFormat = "MMM-dd-yyyy - h:mm:ss a"
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        let updatedDateString = dateFormatter.string(from: yourDate!)
        
        // Print an Action Tremor Result in a cell of table view
        let Title = "Test Execution Time:    " + updatedDateString //String(describing: dateString)
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! ActionTestCell
        cell.testTitle.text = Title
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Function processing click on a particular test result: when clicked it shows particular test information
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        numOfRow = indexPath.row
        performSegue(withIdentifier: "Description", sender: self)
    }
    
    
    // Function for deleting entries: redundant for this version of TremorStat
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //
    //        if editingStyle == .delete {
    //            actionTremorResultArray.remove(at: indexPath.row)
    //
    //            tableView.beginUpdates()
    //            tableView.deleteRows(at: [indexPath], with: .automatic)
    //            tableView.endUpdates()
    //        }
    //    }
}




