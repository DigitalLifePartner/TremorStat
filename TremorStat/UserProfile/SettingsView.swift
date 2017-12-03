//
//  SettingsView.swift
//  TremorStat
//
//  Created by Dayton Pukanich on 12/2/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import Foundation
import UIKit

class SettingsView: UIViewController {
    
    @IBOutlet weak var UpdateIntervalLabel: UILabel!
        @IBOutlet weak var UpdateIntervalSlider: UISlider!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*var formattedUpdateInterval: String {
        updateIntervalFormatter.numberFormatter.minimumFractionDigits = 3
        updateIntervalFormatter.numberFormatter.maximumFractionDigits = 3
        
        let updateInterval = Measurement(value: Double(updateIntervalSlider.value), unit: UnitDuration.seconds)
        return updateIntervalFormatter.string(from: updateInterval)
    }*/
}
