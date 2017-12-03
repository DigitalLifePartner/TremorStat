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
import Charts

class RestTremorApproval: UIViewController {
    
    // MARK: Properties
    
    var results = [[Double]]()
    
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    @IBOutlet weak var meanX: UILabel!
    @IBOutlet weak var stdDevX: UILabel!
    
    
    @IBOutlet weak var meanY: UILabel!
    
    @IBOutlet weak var stdDevY: UILabel!
    @IBOutlet weak var meanZ: UILabel!
    @IBOutlet weak var stdDevZ: UILabel!
    @IBOutlet weak var displayedChart: LineChartView!
    // the actual graph
    
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
        UserDefaults.standard.set(restTremorResultArray, forKey: "restTremorResultArray")
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
        
        // get total offset for the test
        var totalOffset = Array(repeating: 0.0, count: READINGS_PER_TEST)
        var xValues = Array( repeating: 0.0, count: READINGS_PER_TEST )
        
        var xOff = 0.0
        var yOff = 0.0
        var zOff = 0.0
        
        // go thru all elements
        for i in 0...( READINGS_PER_TEST - 1 ) {
            
            // add all offsets ( absolute value )
            xOff = gyroArrayX[ i ]
            if ( xOff < 0 ) {
                xOff = (-1)*xOff
            }
            yOff = gyroArrayY[ i ]
            if ( yOff < 0 ) {
                yOff = (-1)*yOff
            }
            zOff = gyroArrayZ[ i ]
            if ( zOff < 0 ) {
                zOff = (-1)*zOff
            }
            
            totalOffset[i] = xOff + yOff + zOff
            xValues[i] = Double(i)
        }
        
        // prep the displayed chart
        var displayChartEntries = [ChartDataEntry]()
        
        // go thru all y values
            for i in stride(from: 0, to: totalOffset.count - 1, by: 4) {
                
                // set up the x and y axis values
                let value = ChartDataEntry( x: xValues[i], y: totalOffset[i] )
                
                // add to the chartdataentry object
                displayChartEntries.append( value )//insert( value, at: 0 )
                
            }
            
            // make data set based on values and give it a name
            let lineY = LineChartDataSet( values: displayChartEntries, label: "Total Absolute Offset Per Reading" )
            lineY.colors = ChartColorTemplates.colorful()
            lineY.circleRadius = 1.0
            
            // set up a data object
            let restTremorData = LineChartData()
            
            // add the data set to the data
            restTremorData.addDataSet(lineY )
            
            // give chart name and display data
            displayedChart.chartDescription?.text = "Readings at Every Tenth of a Second"
            displayedChart.data = restTremorData
            
            displayedChart.xAxis.labelPosition = .top
        
            //print( "about to declare class" )
        // print ( "statCalc about to be called " )//, statCalc.mean)
        
        // X-values
        var Stat = results[RT_XAVERAGE][0]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.meanX?.text = String( Stat )
        
        Stat = results[RT_XSTDEV][0]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.stdDevX?.text = String( Stat )
        
        // Y-values
        Stat = results[RT_YAVERAGE][0]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.meanY?.text = String( Stat )
        
        Stat = results[RT_YSTDEV][0]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.stdDevY?.text = String( Stat )
        
        // Z-values
        Stat = results[RT_ZAVERAGE][0]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.meanZ?.text = String( Stat )
        
        Stat = results[RT_ZSTDEV][0]
        Stat = self.statCalc.sigFigs( theData: Stat, amountOfFigs: 5 )
        self.stdDevZ?.text = String( Stat )
        
        }
    
  
    @IBAction func SaveChartData(_ sender: Any)
    {
        let image = displayedChart.getChartImage(transparent: false)
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
