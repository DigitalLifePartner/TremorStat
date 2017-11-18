//
//  ViewController.swift
//  YouTube Example
//
//  Created by Sean Allen on 4/28/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
//

import UIKit
import SafariServices

class RestTremorResults: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addVideoTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var data: [String] = ["Test1",
                          "Tes2",
                          "Test3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //        for i in 0...actionTremorResultArray{
        //            data.append(String(i))
        //            let indexPath = IndexPath(row: data.count - 1, section: 0)
        //
        //            tableView.beginUpdates()
        //            tableView.insertRows(at: [indexPath], with: .automatic)
        //            tableView.endUpdates()
        //
        //            view.endEditing(true)
        //        }
    }
    
    
    /*@IBAction func addButtonTapped(_ sender: Any) {
     insertNewTest()
     }*/
    
    
    /*func insertNewTest() {
     
     if addVideoTextField.text!.isEmpty {
     print("Add Video Text Field is empty")
     }
     
     data.append(addVideoTextField.text!)
     
     let indexPath = IndexPath(row: data.count - 1, section: 0)
     
     tableView.beginUpdates()
     tableView.insertRows(at: [indexPath], with: .automatic)
     tableView.endUpdates()
     
     addVideoTextField.text = ""
     view.endEditing(true)
     }*/
}


extension RestTremorResults: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restTremorResultArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var dateString = actionTremorResultArray[indexPath.row].testDate.description
        var dateIndex = dateString.index( dateString.startIndex, offsetBy: 19 ) // to have time included go to 19, to not have time go to 10
        
        let Title = dateString.substring( to: dateIndex )
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! RestTestCell
        cell.testTitle.text = Title
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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





