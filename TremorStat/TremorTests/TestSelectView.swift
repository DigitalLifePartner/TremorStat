//  File Information:
//  TestSelectView
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  Lets the user select a tremor test

import UIKit

class TestSelectView: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var ActiveTremorTestButton: UIButton!
    
    @IBOutlet weak var RestTremorTestButton: UIButton!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        //UserDefaults.standard.set( DataStorage(), forKey: "userData")
        //UserDefaults.standard.set( ConfigDataStorage(), forKey: "userConfigData")
        
        super.viewDidLoad()
        // store data classes to hold memory
        // Do any additional setup after loading the view.
        
        ActiveTremorTestButton.layer.cornerRadius = 25
        RestTremorTestButton.layer.cornerRadius = 25
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // hide navigation controls
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.hidesBackButton = true;
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
