//
//  ApprovalPage.swift
//  TremorStat
//
//  Created by Domenico Di Giovanni on 11/5/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit
import simd

class ApprovalPage: UIViewController {

    @IBOutlet weak var graphView: GraphView!
    var gyroArrayX = Array(repeating: 0.0, count: 1200)
    var gyroArrayY = Array(repeating: 0.0, count: 1200)
    var gyroArrayZ = Array(repeating: 0.0, count: 1200)
    
    var gyroArrayAll: double3!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...1199{
            gyroArrayAll = [ gyroArrayX[i], gyroArrayY[i], gyroArrayZ[i] ]
            self.graphView.add(gyroArrayAll)
        }
        // Do any additional setup after loading the view.
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
