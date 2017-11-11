//
//  SecondUserProfileViewController.swift
//  TremorStat
//
//  Created by Dayton Pukanich on 11/10/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

class SecondUserProfileViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // arrays containing small amounts of data to choose
    let genderArray = ["Male", "Female"]
    let geneticsArray = ["Yes", "No", "Unsure"]
    let traumaArray = ["Yes", "No", "Unsure"]
    let stageArray = ["Not Diagnosed", "Mild", "Moderate", "Severe"]
    
    let dateIndexPath = IndexPath(row: 0, section: 0)
    let genderIndexPath = IndexPath(row: 2, section: 0)
    let geneticsIndexPath = IndexPath(row: 4, section: 0)
    let traumaIndexPath = IndexPath(row: 6, section: 0)
    let stageIndexPath = IndexPath(row: 8, section: 0)
    
    let datePickerIndexPath = IndexPath(row: 1, section: 0)
    let genderPickerIndexPath = IndexPath(row: 3, section: 0)
    let geneticsPickerIndexPath = IndexPath(row: 5, section: 0)
    let traumaPickerIndexPath = IndexPath(row: 7, section: 0)
    let stagePickerIndexPath = IndexPath(row: 9, section: 0)
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var geneticsPicker: UIPickerView!
    @IBOutlet weak var traumaPicker: UIPickerView!
    @IBOutlet weak var stagePicker: UIPickerView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var geneticsLabel: UILabel!
    @IBOutlet weak var traumaLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBAction func dateValueChanged(sender: UIDatePicker) {
        dateLabel.text = DateFormatter.localizedString(from: datePicker.date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    }
    
    // run when view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigation
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // bring up tab controller
        self.tabBarController?.tabBar.isHidden = false
        
        // set default values
        //datePicker.date = Date()
        dateValueChanged(sender: datePicker)
        stageLabel.text = "N/A"
        geneticsLabel.text = "N/A"
        traumaLabel.text = "N/A"
        genderLabel.text = "N/A"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPicker.delegate = self
        geneticsPicker.delegate = self
        stagePicker.delegate = self
        traumaPicker.delegate = self

        genderPicker.dataSource = self
        geneticsPicker.dataSource = self
        stagePicker.dataSource = self
        traumaPicker.dataSource = self
        
        setPickersIsHidden(hidden: true)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    // return the number of components
    func numberOfComponents(in pickerView : UIPickerView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let minimizedHeight = CGFloat(0.0)
        let extendedHeight = CGFloat(216.0)
        var height = super.tableView(tableView, heightForRowAt: indexPath)
        
        if datePickerIndexPath == indexPath {
            height = datePicker.isHidden ? minimizedHeight : extendedHeight
        }
        else if genderPickerIndexPath == indexPath {
            height = genderPicker.isHidden ? minimizedHeight : extendedHeight
        }
        else if geneticsPickerIndexPath == indexPath {
            height = geneticsPicker.isHidden ? minimizedHeight : extendedHeight
        }
        else if traumaPickerIndexPath == indexPath {
            height = traumaPicker.isHidden ? minimizedHeight : extendedHeight
        }
        else if stagePickerIndexPath == indexPath {
            height = stagePicker.isHidden ? minimizedHeight : extendedHeight
        }

        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var hidden = true
        
        if dateIndexPath == indexPath {
            hidden = datePicker.isHidden
        }
        else if genderIndexPath == indexPath {
            hidden = genderPicker.isHidden
        }
        else if geneticsIndexPath == indexPath {
            hidden = geneticsPicker.isHidden
        }
        else if traumaIndexPath == indexPath {
            hidden = traumaPicker.isHidden
        }
        else if stageIndexPath == indexPath {
            hidden = stagePicker.isHidden
        }
        
        setPickersIsHidden(hidden: true)
        
        if dateIndexPath == indexPath && hidden == true {
            datePicker.isHidden = !datePicker.isHidden
        }
        else if genderIndexPath == indexPath && hidden == true {
            genderPicker.isHidden = !genderPicker.isHidden
        }
        else if geneticsIndexPath == indexPath && hidden == true {
            geneticsPicker.isHidden = !geneticsPicker.isHidden
        }
        else if traumaIndexPath == indexPath && hidden == true {
            traumaPicker.isHidden = !traumaPicker.isHidden
        }
        else if stageIndexPath == indexPath && hidden == true {
            stagePicker.isHidden = !stagePicker.isHidden
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tableView.beginUpdates()
            // apple bug fix - some TV lines hide after animation
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.tableView.endUpdates()
        })
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
    
    func setPickersIsHidden(hidden: Bool) {
        datePicker.isHidden = hidden
        genderPicker.isHidden = hidden
        geneticsPicker.isHidden = hidden
        traumaPicker.isHidden = hidden
        stagePicker.isHidden = hidden
    }
    
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
