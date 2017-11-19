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
    
    var numOfRow = 0
    
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


        // pass the array to the Description page view
        let nextController = segue.destination as! ActionTremorResultsDescription
        nextController.results = actionTremorResultArray[numOfRow]


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
        numOfRow = indexPath.row
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




