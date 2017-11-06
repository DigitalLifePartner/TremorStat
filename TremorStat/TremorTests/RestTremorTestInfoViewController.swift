//
//  RestTremorTestInfoViewController.swift
//  TremorStat
//
//  Created by Best Software on 11/5/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

class RestTremorTestInfoViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var StartTestButton: UIButton!

    // MARK: IB Actions
    
    @IBAction func RestTest(_ sender: Any) {
        //if the rest tremor test button was pressed, segue to the countdown page for the test
        performSegue(withIdentifier: "CountdownViewController", sender: self)
    }
    
    // MARK: Overrides

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartTestButton.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
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
