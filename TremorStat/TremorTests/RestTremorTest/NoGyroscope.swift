

//  File Information:
//  TestSelectView
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  Determine whether or not the user wishes to keep the data
//  from the recently completed test

import UIKit
import simd

class NoGyroscope: UIViewController {
    
    // MARK: Properties
    
    // Array containing all Action Tremor Test results
    var restTremorResultArray = [[Double]]()
    
    // component arrays of the X Y Z values
    // each is of size 1200 elements as 30 seconds divided by 0.025 second intervals is 1200
    var gyroArrayX = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayY = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayZ = Array(repeating: 0.0, count: READINGS_PER_TEST)
    
    //Instantiating Statistics class for data representation
    var statisticsCalculator = StatisticsCalculator()
    
    // Create an array for the result data
    var results = Array(repeating: 0.0, count: 7)
    
    // Variable to check if randomized values are to be generated
    var finishedTest = false
    
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    // Feed randomized values for testing purposes
    @IBAction func SaveRandomData(_ sender: Any) {
        
        // Create a Random set of x, y, z offsets
        for i in 0...READINGS_PER_TEST-1{
            gyroArrayX[i]=(Double(arc4random_uniform(4))-Double(arc4random_uniform(4)))/2
            gyroArrayY[i]=(Double(arc4random_uniform(4))-Double(arc4random_uniform(4)))/2
            gyroArrayZ[i]=(Double(arc4random_uniform(4))-Double(arc4random_uniform(4)))/2
        }
        
        //Store date of the test
        results[RT_TIME]=(Double(Date().timeIntervalSince1970))
        
        //Store average offset values
        results[RT_XAVERAGE]=(statisticsCalculator.calcMean(theData: gyroArrayX, theSize: gyroArrayX.count, absolute: true))
        results[RT_YAVERAGE]=(statisticsCalculator.calcMean(theData: gyroArrayY, theSize: gyroArrayY.count, absolute: true))
        results[RT_ZAVERAGE]=(statisticsCalculator.calcMean(theData: gyroArrayZ, theSize: gyroArrayZ.count, absolute: true))
        
        //Store stdandart deviation of the offset
        results[RT_XSTDEV]=(statisticsCalculator.calcStdDev(theData: gyroArrayX, theSize: gyroArrayX.count, gotMean: false, absolute: true))
        results[RT_YSTDEV]=(statisticsCalculator.calcStdDev(theData: gyroArrayY, theSize: gyroArrayX.count, gotMean: false, absolute: true))
        results[RT_ZSTDEV]=(statisticsCalculator.calcStdDev(theData: gyroArrayZ, theSize: gyroArrayZ.count, gotMean: false, absolute: true))
        
        // segue back to the test approval page
        goToApprove()
        
    }
    
    
    func goToApprove() {
        
        // Get data from associated key
        restTremorResultArray = getDataFromKey(key: "restTremorResultArray")
        
        //Store date of the test
        results[RT_TIME]=(Double(Date().timeIntervalSince1970))
        
        // segue back to the test approval page
        restTremorResultArray.append( self.results )
        UserDefaults.standard.set(restTremorResultArray, forKey: "restTremorResultArray")
        finishedTest = true
        performSegue(withIdentifier: "ApprovePage", sender: self)
    }
    
    
    // MARK: Overrides
    
    // should any other segue happen during a test - stop the test
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if finishedTest == true {
            finishedTest = false
            // pass the component arrays to the approval view
            let nextController = segue.destination as! RestTremorApproval
            nextController.results=self.results
            nextController.gyroArrayX = self.gyroArrayX
            nextController.gyroArrayY = self.gyroArrayY
            nextController.gyroArrayZ = self.gyroArrayZ
        }
    }
    
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
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
