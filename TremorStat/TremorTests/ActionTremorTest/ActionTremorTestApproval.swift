//
//  ActionTremorTestApprovalPageViewController.swift
//
//
//  Created by Milos Savic on 11/12/17.
//
import UIKit

class ActionTremorTestApproval: UIViewController {
    
    var actionTremorResultArray = [[[Double]]]()
    
    @IBOutlet weak var avgFrequencyLabel: UILabel!
    @IBOutlet weak var avgDevianceLabel: UILabel!
    @IBOutlet weak var numTapsLabel: UILabel!
    
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    @IBAction func noMainPageAction(_ sender: Any) {
        
        //Store previous Action Tremor Test results in the array
        self.actionTremorResultArray = getDataFromKey(key: "actionTremorResultArray")
        

        //Remove the last saved element from the array
        let lastElement = actionTremorResultArray.count - 1
        actionTremorResultArray.remove(at: lastElement)
        
        //Store test results under associated key
        UserDefaults.standard.set(actionTremorResultArray, forKey: "actionTremorResultArray")
        performSegue(withIdentifier: "noMainPageAction", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YesButton.layer.cornerRadius = 25
        NoButton.layer.cornerRadius = 25
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        avgFrequencyLabel.text = String((Double(round(avgTime*1000)/1000)))
        avgDevianceLabel.text = String((Double(round(avgDeviance*1000)/1000)))
        numTapsLabel.text = String(numTaps)
        
        
    }
    
    
}
