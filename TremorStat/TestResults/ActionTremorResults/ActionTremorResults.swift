//
//  ViewController.swift
//  YouTube Example
//
//  Created by Sean Allen on 4/28/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
//

import UIKit
import SafariServices

class ActionTremorResults: UIViewController, UITextFieldDelegate {
    
    var actionTremorResultArray = [[Double]]()
    
    @IBOutlet weak var addVideoTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //Store previous Action Tremor Test results in the array
        self.actionTremorResultArray = getDataFromKey(key: "actionTremorResultArray")
        
        //Update table
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // stop gyro updates
        self.stopUpdates()
        
        // specific case for segue into the test approval view
        if finishedTest == true {
            finishedTest = false
            
            // pass the component arrays to the approval view
            let nextController = segue.destination as! RestTremorApproval
            nextController.results=self.results
            nextController.gyroArrayX = self.gyroArrayX
            nextController.gyroArrayY = self.gyroArrayY
            nextController.gyroArrayZ = self.gyroArrayZ
            
            let nextController = segue.destination as! ActionTremorResultsDescription
        }

}
}

extension ActionTremorResults: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Store previous Action Tremor Test results in the array
        return actionTremorResultArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var dateString = NSDate(timeIntervalSince1970:(actionTremorResultArray[indexPath.row])[0])
        
        let Title = String(describing: dateString)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! ActionTestCell
        cell.testTitle.text = Title
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Description", sender: self)
    }
    
    
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




