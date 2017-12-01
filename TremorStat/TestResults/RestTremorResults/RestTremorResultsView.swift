//
//  RestTremorResultsView.swift
//  TremorStat
//
//  Created by Milos Savic on 11/27/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

class RestTremorResultsView: UIViewController {

    @IBOutlet weak var PlotAllData: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlotAllData.layer.cornerRadius = 25
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
