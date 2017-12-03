//  File Information:
//  TestResultsView
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The visulization for the test results


import UIKit

class TestResultsView: UIViewController {
    
    @IBOutlet weak var ActiveTremorTestResultsButton: UIButton!
    @IBOutlet weak var RestTremorTestResultsButton: UIButton!
    @IBOutlet weak var TestResultsAnalysisButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        ActiveTremorTestResultsButton.layer.cornerRadius = 25
        RestTremorTestResultsButton.layer.cornerRadius = 25
        TestResultsAnalysisButton.layer.cornerRadius = 25

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
