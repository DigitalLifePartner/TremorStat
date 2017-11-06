//
//  ApprovalViewController.swift
//  TremorStat
//
//  Created by Best Software on 11/5/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

/* VERSION 1
 
 Done:
     - passed data from test page to this one
     - graphed data correctly
     - scaled graph
     - have buttons
 
 To Do:
     - have buttons either store / discard data
 */
import UIKit
import simd

// Purpose: Determine whether or not the user wishes to keep the data from the previous test
class ApprovalViewController: UIViewController {

    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    // MARK: variables
    
    // the actual graph
    @IBOutlet weak var graphView: GraphView!
    
    // component arrays of the X Y Z values
    // each is of size 1200 elements as 30 seconds divided by 0.025 second intervals is 1200
    var gyroArrayX = Array(repeating: 0.0, count: 1200)
    var gyroArrayY = Array(repeating: 0.0, count: 1200)
    var gyroArrayZ = Array(repeating: 0.0, count: 1200)
    
    // essentially a variable containing 3 doubles -- for the X Y Z coordinates
    var gyroArrayAll: double3!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YesButton.layer.cornerRadius = 25
        NoButton.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    
    // MARK: UIViewController properties
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigation controls during test
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true

        for i in 0...1199{
            // add all data from components into a single data set
            gyroArrayAll = [ gyroArrayX[i], gyroArrayY[i], gyroArrayZ[i] ]
            
            // add data set to the graph
            self.graphView.add(gyroArrayAll)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
