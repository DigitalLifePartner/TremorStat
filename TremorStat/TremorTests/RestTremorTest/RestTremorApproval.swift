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

class RestTremorApproval: UIViewController {
    
    // MARK: Properties
    
    var results = [Double]()
    
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
    
    @IBAction func deleteThisTest(_ sender: Any) {
        //get the data array from the key and determine its length
        var restTremorResultArray = getDataFromKey(key: "restTremorResultArray")
        let lastElement = getDataFromKey(key: "restTremorResultArray").count - 1
        //print ( "count before removal = " , restTremorResultArray.count )
        //print ( "trying to remove element " , lastElement )
        restTremorResultArray.remove(at: lastElement)
        //print ( "removed last element, count is now " , restTremorResultArray.count )
        performSegue(withIdentifier: "noMainPage", sender: self)
    }
    
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
        
        for i in 0...(READINGS_PER_TEST-1){
            // add all data from components into a single data set
            gyroArrayAll = [ gyroArrayX[i], gyroArrayY[i], gyroArrayZ[i] ]
            
            // add data set to the graph
            self.graphView.add(gyroArrayAll)
        }
        
        //print( "about to declare class" )
        // print ( "statCalc about to be called " )//, statCalc.mean)
        
        // X-values
        var Stat = results[RT_XAVERAGE]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.meanX?.text = String( Stat )
        
        Stat = results[RT_XSTDEV]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.stdDevX?.text = String( Stat )
        
        // Y-values
        Stat = results[RT_YAVERAGE]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.meanY?.text = String( Stat )
        
        Stat = results[RT_YSTDEV]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.stdDevY?.text = String( Stat )
        
        // Z-values
        Stat = results[RT_ZAVERAGE]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.meanZ?.text = String( Stat )
        
        Stat = results[RT_ZSTDEV]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.stdDevZ?.text = String( Stat )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
