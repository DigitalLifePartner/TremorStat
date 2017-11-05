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
    var dataArray: Array<double3>!
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...dataArray.count{
            graphView.add(dataArray[i])
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
