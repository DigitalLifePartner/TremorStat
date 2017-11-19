//
//  RestTremorResults
//  TremorStat
//
//  Created by Best Software on 11/10/17.
//  Copyright © 2017 Best Software. All rights reserved.
//
//

import UIKit
import SafariServices

class RestTremorResults: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addVideoTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
}


extension RestTremorResults: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restTremorResultArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var dateString = restTremorResultArray[indexPath.row].testDate.description
        var dateIndex = dateString.index( dateString.startIndex, offsetBy: 19 ) // to have time included go to 19, to not have time go to 10
        
        let Title = dateString.substring( to: dateIndex )
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! RestTestCell
        cell.testTitle.text = Title
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //
    //        if editingStyle == .delete {
    //            actionTremorResultArray.remove(at: indexPath.row)
    //
    //            tableView.beginUpdates()
    //            tableView.deleteRows(at: [indexPath], with: .automatic)
    //            tableView.endUpdates()
    //        }
    //    }
}





