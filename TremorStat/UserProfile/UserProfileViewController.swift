//
//  UserProfileViewController.swift
//  TremorStat
//
//  Created by Best Software on 11/5/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

// Purpose: allow user to change details of their profile
class UserProfileViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: properties
    
    // used to determine if section should be hidden
    var isDatePickerHidden = true
    var isGenderPickerHidden = true
    var isGeneticsPickerHidden = true
    var isTraumaPickerHidden = true
    var isStagePickerHidden = true
    
    // arrays containing small amounts of data to choose
    let genderArray = ["Male", "Female"]
    let geneticsArray = ["Yes", "No", "Unsure"]
    let traumaArray = ["Yes", "No", "Unsure"]
    let stageArray = ["Not Diagnosed", "Mild", "Moderate", "Severe"]

    // labels and views
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var geneticsLabel: UILabel!
    @IBOutlet weak var traumaLabel: UILabel!
    @IBOutlet weak var stageLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var geneticsPicker: UIPickerView!
    @IBOutlet weak var traumaPicker: UIPickerView!
    @IBOutlet weak var stagePicker: UIPickerView!

    
    // MARK: IB actions
    
    // change date picker
    @IBAction func datePickerValue(sender: UIDatePicker) {
        datePickerChanged()
    }
    
    // MARK: overrides
    
    // run when view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigation
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // bring up tab controller
        self.tabBarController?.tabBar.isHidden = false

        // set default values
        dateLabel.text = "N/A"
        genderLabel.text = "N/A"
        geneticsLabel.text = "N/A"
        traumaLabel.text = "N/A"
        stageLabel.text = "N/A"
    }
    
    // run when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // change the state of pickers when called, and then update the table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       //print(String(indexPath.row), " ", String(indexPath.section), "\n")
        
        
        // change hidden states of pickers if selected
        if indexPath.section == 0 && indexPath.row == 0 {
            isDatePickerHidden = !isDatePickerHidden
        }
        else if indexPath.section == 1 && indexPath.row == 0 {
            isGenderPickerHidden = !isGenderPickerHidden
        }
        else if indexPath.section == 2 && indexPath.row == 0 {
            isGeneticsPickerHidden = !isGeneticsPickerHidden
        }
        else if indexPath.section == 3 && indexPath.row == 0 {
            isTraumaPickerHidden = !isTraumaPickerHidden
        }
        else if indexPath.section == 4 && indexPath.row == 0 {
            isStagePickerHidden = !isStagePickerHidden
        }
        
        // run through updates
        tableView.beginUpdates()
        tableView.endUpdates()
        
        // deselect current row when done
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // change the height of the picker rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // manipulate height of picker row ( if height = 0 it is hidden )
        if isDatePickerHidden && indexPath.section == 0 && indexPath.row == 1 {
            return 0
        }
        else if isGenderPickerHidden && indexPath.section == 1 && indexPath.row == 1 {
            return 0
        }
        else if isGeneticsPickerHidden && indexPath.section == 2 && indexPath.row == 1 {
            return 0
        }
        else if isTraumaPickerHidden && indexPath.section == 3 && indexPath.row == 1 {
            return 0
        }
        else if isStagePickerHidden && indexPath.section == 4 && indexPath.row == 1 {
            return 0
        }
        
        return super.tableView(self.tableView, heightForRowAt: indexPath)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: implementation

    // return the number of components
    func numberOfComponents(in pickerView : UIPickerView) -> Int {
        return 1
    }
    
    // get the row required based on the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var rows = 0;
        
        // set the value of rows based on the amount of data in the given category
        if pickerView == genderPicker {
            rows = genderArray.count
        }
        else if pickerView == geneticsPicker {
            rows = geneticsArray.count
        }
        else if pickerView == traumaPicker {
            rows = traumaArray.count
        }
        else if pickerView == stagePicker {
            rows = stageArray.count
        }
        
        return rows
    }
    
    // once you have the row, use this to get the value from the row based on the picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rowValue = "";
        
        // get the row value based on value in category
        if pickerView == genderPicker {
            rowValue = genderArray[row]
        }
        else if pickerView == geneticsPicker {
            rowValue = geneticsArray[row]
        }
        else if pickerView == traumaPicker {
            rowValue = traumaArray[row]
        }
        else if pickerView == stagePicker {
            rowValue = stageArray[row]
        }
        
        return rowValue
    }
    
    // change the text of the various labels based on the new data
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // change text of view based on value in category
        if pickerView == genderPicker {
            genderLabel.text = genderArray[row]
        }
        else if pickerView == geneticsPicker {
            geneticsLabel.text = geneticsArray[row]
        }
        else if pickerView == traumaPicker {
            traumaLabel.text = traumaArray[row]
        }
        else if pickerView == stagePicker {
            stageLabel.text = stageArray[row]
        }
    }
    
    // change the date label to reflect new data
    func datePickerChanged () {
        // set the label text
        dateLabel.text = DateFormatter.localizedString(from: datePicker.date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    }
    
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}