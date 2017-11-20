//  File Information:
//  RestTremorResultsDescription
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The visulization of a particular rest tremor test

import UIKit

class RestTremorResultsDescription: UIViewController {
    
    
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
        var dateString = NSDate(timeIntervalSince1970:(results[0]))
        dateLabel.text = String(describing: dateString)
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

