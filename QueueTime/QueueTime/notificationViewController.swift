//
//  notificationViewController.swift
//  QueueTime
//
//  Created by Rens de Meulemeester on 20/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import UIKit
import Intents

class notificationViewController: UIViewController {

    
    
    @IBAction func button(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        INPreferences.requestSiriAuthorization { (status) in
            
            if status == .authorized {
                print("Siri access allowed")
            }
            
            else {
                print("Siri access denied")
            }
            
            
        }
        
         DataManager.sharedManager.saveContacts(contacts: [["name": "Rens", "number": "0623674821"], ["name": "Tim", "number": "0678123595"], ["name": "Xandor", "number": "0640209467"], ["name": "Steven", "number": "0653409248"]])
        
    }
    

}
