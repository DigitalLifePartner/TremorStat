//
//  ActionTremorTestApprovalPageViewController.swift
//
//
//  Created by Milos Savic on 11/12/17.
//
import UIKit

class ActionTremorTestApproval: UIViewController {
    
    
    @IBOutlet weak var HighScoreLabel: UILabel!
    @IBOutlet weak var UserScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if let highScoreValue = UserDefaults.standard.object(forKey: "LastTestTaps") as? integer_t
        {
            HighScoreLabel.text = String(highScoreValue)
        }
        
        if let userScore = UserDefaults.standard.object(forKey: "LastUserScore") as? integer_t
        {
            UserScore.text = String(userScore)
        }
        
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
