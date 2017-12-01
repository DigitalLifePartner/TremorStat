//  File Information:
//  RestTremorResults
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The visulization of the action tremor test results

import UIKit
import SafariServices

class RestTremorResults: UIViewController, UITextFieldDelegate {
    
    // Array that stores all Action Tremor Test results
    var restTremorResultArray = [[[Double]]]()
    
    var numOfRow = 0
    
    @IBOutlet weak var addVideoTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Store previous Rest Tremor Test results in the array
        self.restTremorResultArray = getDataFromKey(key: "restTremorResultArray")
        
        // Reverse the array so that latest test results are processed first
        restTremorResultArray=restTremorResultArray.reversed()
        
        //Update table view
        tableView.reloadData()
    }
    
    // Segue for passing particular test results to RestTremorResultsDescription view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass the results for picked tast to the Description page view to show information about it
        let nextController = segue.destination as! RestTremorResultsDescription
        nextController.results = restTremorResultArray[numOfRow]
    }
}

extension RestTremorResults: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Store previous Rest Tremor Test results in the array
        return restTremorResultArray.count
    }
    
    
    // Function printing all Rest Tremor Results in a table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Code below transforms a Date type in a readable format
        var dateString = Date(timeIntervalSince1970:(restTremorResultArray[indexPath.row][RT_TIME][0]))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let mystring = dateFormatter.string(from: dateString);
        let yourDate: Date? = dateFormatter.date(from: mystring)
        dateFormatter.dateFormat = "MMM-dd-yyyy - h:mm:ss a"
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        let updatedDateString = dateFormatter.string(from: yourDate!)
        
        // Print an Rest Tremor Result in a cell of table view
        let Title = "Test Execution Time:    " + updatedDateString //String(describing: dateString)
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! RestTestCell
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
    //            restTremorResultArray.remove(at: indexPath.row)
    //
    //            tableView.beginUpdates()
    //            tableView.deleteRows(at: [indexPath], with: .automatic)
    //            tableView.endUpdates()
    //        }
    //    }
}




