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

    @IBOutlet weak var ActiveTremorTestButton: UIButton!
    
    @IBOutlet weak var RestTremorTestButton: UIButton!
    
    // MARK: UIViewController properties
    override func viewDidLoad() {
        super.viewDidLoad()

        ActiveTremorTestButton.layer.cornerRadius = 25
        //RestTremorTestButton.layer.cornerRadius = 25
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
