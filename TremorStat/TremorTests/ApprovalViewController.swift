//  File Information:
//  TestSelectViewController
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  Determine whether or not the user wishes to keep the data
//  from the recently completed test

import UIKit
import simd

class ApprovalViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    @IBOutlet weak var meanX: UILabel!
    @IBOutlet weak var stdDevX: UILabel!
    
    
    @IBOutlet weak var meanY: UILabel!
    
    @IBOutlet weak var stdDevY: UILabel!
    @IBOutlet weak var meanZ: UILabel!
    @IBOutlet weak var stdDevZ: UILabel!
    // the actual graph
    @IBOutlet weak var graphView: GraphView!
    
    var statCalc = StatisticsCalculator()
    
    // component arrays of the X Y Z values
    // each is of size 1200 elements as 30 seconds divided by 0.025 second intervals is 1200
    var gyroArrayX = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayY = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayZ = Array(repeating: 0.0, count: READINGS_PER_TEST)
    
    // essentially a variable containing 3 doubles -- for the X Y Z coordinates
    var gyroArrayAll: double3!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YesButton.layer.cornerRadius = 25
        NoButton.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    
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
        
        print( "about to declare class" )
        //var statCalc: StatisticsCalculator!
        print ( "statCalc about to be called " )//, statCalc.mean)

        // X-values
        var Stat = self.statCalc.calcMean( theData: self.gyroArrayX, theSize: READINGS_PER_TEST, absolute: true )
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.meanX?.text = String( Stat )
        
        Stat = self.statCalc.calcStdDev( theData: self.gyroArrayX, theSize: READINGS_PER_TEST, gotMean: true, absolute: true )
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.stdDevX?.text = String( Stat )
        
        // Y-values
        Stat = self.statCalc.calcMean( theData: self.gyroArrayY, theSize: READINGS_PER_TEST, absolute: true )
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.meanY?.text = String( Stat )
        
        Stat = self.statCalc.calcStdDev( theData: self.gyroArrayY, theSize: READINGS_PER_TEST, gotMean: true, absolute: true )
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.stdDevY?.text = String( Stat )
        
        // Z-values
        Stat = self.statCalc.calcMean( theData: self.gyroArrayZ, theSize: READINGS_PER_TEST, absolute: true )
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.meanZ?.text = String( Stat )
        
        Stat = self.statCalc.calcStdDev( theData: self.gyroArrayZ, theSize: READINGS_PER_TEST, gotMean: true, absolute: true )
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.stdDevZ?.text = String( Stat )
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
