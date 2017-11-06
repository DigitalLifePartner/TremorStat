//
//  RestTremorTestInfoViewController.swift
//  TremorStat
//
//  Created by Milos Savic on 11/5/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

class RestTremorTestInfoViewController: UIViewController {

    @IBOutlet weak var StartTestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartTestButton.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RestTest(_ sender: Any) {
         //if the rest tremor test button was pressed, segue to the countdown page for the test
        performSegue(withIdentifier: "CountdownViewController", sender: self)
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
