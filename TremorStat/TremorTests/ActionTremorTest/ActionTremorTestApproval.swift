//
//  ActionTremorTestApprovalPageViewController.swift
//
//
//  Created by Milos Savic on 11/12/17.
//
import UIKit

class ActionTremorTestApproval: UIViewController {
    
    @IBOutlet weak var avgFrequencyLabel: UILabel!
    @IBOutlet weak var avgDevianceLabel: UILabel!
    @IBOutlet weak var numTapsLabel: UILabel!
    
    
    @IBAction func noMainPageAction(_ sender: Any) {
        
        let lastElement = actionTremorResultArray.count - 1
        actionTremorResultArray.remove(at: lastElement)
        performSegue(withIdentifier: "noMainPageAction", sender: self)
    }
    
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
        
        avgFrequencyLabel.text = String(avgTime)
        
        avgDevianceLabel.text = String(avgDeviance)
        
        numTapsLabel.text = String(numTaps)
        
        
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
