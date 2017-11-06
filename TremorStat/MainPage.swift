//
//  MainPage.swift
//  TremorStat
//
//  Created by Domenico Di Giovanni on 11/4/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

/* VERSION 1
 
 Done:
     - added page
 
 To Do:
     - ???
 */
import UIKit

// Purpose: central page for the tests
class MainPage: UIViewController {

    // MARK: UIViewController properties
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigation controls
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: implementation
    @IBAction func RestTest(_ sender: Any) {
        // if the rest tremor test button was pressed, segue to the countdown page for the test
        performSegue(withIdentifier: "CountdownPage", sender: self)
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
