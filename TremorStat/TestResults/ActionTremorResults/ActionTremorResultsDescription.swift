//
//  ActionTremorResultsDescription.swift
//  TremorStat
//
//  Created by Milos Savic on 11/18/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

class ActionTremorResultsDescription: UIViewController {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var devianceLabel: UILabel!
    
    
    var results = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        dateLabel.text = String(results[0])
        averageLabel.text = String(results[1])
        devianceLabel.text = String(results[2])
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
