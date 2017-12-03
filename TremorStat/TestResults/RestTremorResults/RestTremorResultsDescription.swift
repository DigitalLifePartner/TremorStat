//  File Information:
//  RestTremorResultsDescription
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The visulization of a particular rest tremor test

import UIKit
import Charts

class RestTremorResultsDescription: UIViewController {
    
    
    // Lable declaration for various test parameters
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var xOffSet: UILabel!
    @IBOutlet weak var xStdDev: UILabel!
    
    @IBOutlet weak var yOffSet: UILabel!
    @IBOutlet weak var yStdDev: UILabel!
    
    @IBOutlet weak var zOffSet: UILabel!
    @IBOutlet weak var zStdDev: UILabel!
    
    
    @IBOutlet weak var xOffsetLabel: UILabel!
    @IBOutlet weak var yOffsetLabel: UILabel!
    @IBOutlet weak var zOffsetLabel: UILabel!
    
    @IBOutlet weak var xDeviationLabel: UILabel!
    @IBOutlet weak var yDeviationLabel: UILabel!
    @IBOutlet weak var zDeviationLabel: UILabel!
    
    @IBOutlet var displayedChart: LineChartView!
    @IBOutlet weak var amountWithinAverageLabel: UILabel!
    // Array storing result of the test
    var results = [[Double]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Print test results when view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        
        // Code below transforms a Date type in a readable format
        var dateString = Date(timeIntervalSince1970:(results[RT_TIME][0]))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let mystring = dateFormatter.string(from: dateString);
        let yourDate: Date? = dateFormatter.date(from: mystring)
        dateFormatter.dateFormat = "MMM-dd-yyyy - h:mm:ss a"
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        
        // Print an date of the test in the appropriate labels
        let updatedDateString = dateFormatter.string(from: yourDate!)
        dateLabel.text = updatedDateString;
        
        updateToBasicView();
        
        // get total offset for the test
        var totalOffset = Array(repeating: 0.0, count: READINGS_PER_TEST)
        var xValues = Array( repeating: 0.0, count: READINGS_PER_TEST )
        
        var xOff = 0.0
        var yOff = 0.0
        var zOff = 0.0
        
        // go thru all elements
        for i in 0...( READINGS_PER_TEST - 1 ) {
            
            // add all offsets ( absolute value )
            xOff = results[ RT_XOFFSET ][ i ]
            if ( xOff < 0 ) {
                xOff = (-1)*xOff
            }
            yOff = results[ RT_YOFFSET ][ i ]
            if ( yOff < 0 ) {
                yOff = (-1)*yOff
            }
            zOff = results[ RT_ZOFFSET ][ i ]
            if ( zOff < 0 ) {
                zOff = (-1)*zOff
            }
            
            totalOffset[i] = xOff + yOff + zOff
            xValues[i] = Double(i)
        }
        
    
        // display the percentage
        //amountWithinAverageLabel.text = String( percentage ) + "% of your results are within average ranges."
        
        // prep the displayed chart
        var displayChartEntries = [ChartDataEntry]()
        
        // go thru all y values
        if ( totalOffset.count > 0 ) {
            
            for i in stride(from: 0, to: totalOffset.count - 1, by: 4) {
                
                // set up the x and y axis values
                let value = ChartDataEntry( x: xValues[i], y: totalOffset[i] )
                print( "adding to x coord " , xValues[i], " and y coord " , totalOffset[i] )
                
                // add to the chartdataentry object
                displayChartEntries.append( value )//insert( value, at: 0 )
                
            }
            
            // make data set based on values and give it a name
            let lineY = LineChartDataSet( values: displayChartEntries, label: "Total Absolute Offset Per Reading" )
            lineY.colors = ChartColorTemplates.colorful()
            lineY.circleColors = ChartColorTemplates.colorful()
            lineY.circleRadius = 1.0
            
            let averageLimit = ChartLimitLine(limit: AVG_PERSON_PLUS_STDDEV, label: "Average")
            
            // set up a data object
            let restTremorData = LineChartData()
            
            // add the data set to the data
            restTremorData.addDataSet(lineY )
            
            // give chart name and display data
            displayedChart.chartDescription?.text = "Readings at Every Tenth of a Second"
            displayedChart.data = restTremorData
            displayedChart.rightAxis.addLimitLine(averageLimit)
            
            
            //barChartView.xAxis.labelPosition = .Bottom
            
            displayedChart.xAxis.labelPosition = .top
        
        }
    }
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func IndexChanged(_ sender: Any)
    {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            updateToBasicView();
            
        case 1:
            updateToScientificView()
            
        default:
            break
        }
        
        
    }
    
    func updateToBasicView()
    {
        xStdDev.isHidden = true;
        xOffSet.isHidden = true;
        yStdDev.isHidden = true;
        yOffSet.isHidden = true;
        zStdDev.isHidden = true;
        zOffSet.isHidden = true;
        xOffsetLabel.isHidden = true;
        yOffsetLabel.isHidden = true;
        zOffsetLabel.isHidden = true;
        xDeviationLabel.isHidden = true;
        yDeviationLabel.isHidden = true;
        zDeviationLabel.isHidden = true;
        
    }
    
    func updateToScientificView()
    {
        
        xStdDev.text = "X offset (rad/s):"
        xOffSet.text = "X StdDeviation (rad/s)"
        
        yStdDev.text = "Y offset (rad/s):"
        yOffSet.text = "Y StdDeviation (rad/s)"
        
        zStdDev.text = "Z offset (rad/s):"
        zOffSet.text = "Z StdDeviation (rad/s)"
        
        yStdDev.isHidden = true;
        yOffSet.isHidden = true;
        zStdDev.isHidden = true;
        zOffSet.isHidden = true;
        
        xStdDev.isHidden = false;
        xOffSet.isHidden = false;
        yStdDev.isHidden = false;
        yOffSet.isHidden = false;
        zStdDev.isHidden = false;
        zOffSet.isHidden = false;
        xOffsetLabel.isHidden = false;
        yOffsetLabel.isHidden = false;
        zOffsetLabel.isHidden = false;
        xDeviationLabel.isHidden = false;
        yDeviationLabel.isHidden = false;
        zDeviationLabel.isHidden = false;
        
        
        // Print x,y,z offsets in appropriate labels
        xOffsetLabel.text = String(Double(round(10000*results[RT_XAVERAGE][0])/10000))
        yOffsetLabel.text = String(Double(round(10000*results[RT_YAVERAGE][0])/10000))
        zOffsetLabel.text = String(Double(round(10000*results[RT_ZAVERAGE][0])/10000))
        
        // Print x,y,z deviations in appropriate labels
        xDeviationLabel.text = String(Double(round(10000*results[RT_XSTDEV][0])/10000))
        yDeviationLabel.text = String(Double(round(10000*results[RT_YSTDEV][0])/10000))
        zDeviationLabel.text = String(Double(round(10000*results[RT_ZSTDEV][0])/10000))
        
        // find out how many of the users results are within the average range
        var statCalc = StatisticsCalculator()
        
        // get total offset for the test
        var totalOffset = Array(repeating: 0.0, count: READINGS_PER_TEST)
        var xValues = Array( repeating: 0.0, count: READINGS_PER_TEST )
        
        var xOff = 0.0
        var yOff = 0.0
        var zOff = 0.0
        
        // go thru all elements
        for i in 0...( READINGS_PER_TEST - 1 ) {
            
            // add all offsets ( absolute value )
            xOff = results[ RT_XOFFSET ][ i ]
            if ( xOff < 0 ) {
                xOff = (-1)*xOff
            }
            yOff = results[ RT_YOFFSET ][ i ]
            if ( yOff < 0 ) {
                yOff = (-1)*yOff
            }
            zOff = results[ RT_ZOFFSET ][ i ]
            if ( zOff < 0 ) {
                zOff = (-1)*zOff
            }
            
            totalOffset[i] = xOff + yOff + zOff
            xValues[i] = Double(i)
        }
        
        // get an array of doubles that are within the average tremor ranges
        let inAverageRange = statCalc.searchAndMakeWithinInterval( theArray: totalOffset, leftMostVal: 0.0, rightMostVal: AVG_PERSON_PLUS_STDDEV )
        
        // compare sizes of the returned array with the original and get the percentage
        var percentage = ( Double( inAverageRange.count - 1 )/Double( READINGS_PER_TEST ) )*100.0
        percentage = Double ( round( 100*percentage ) )
        percentage = percentage/100.0
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

