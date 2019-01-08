//
//  ViewController.swift
//  QueueTime
//
//  Created by Ivo van der Zee on 06/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import UIKit
import Intents

class ViewController: UIViewController {

    //Outlets for the loginscreen
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    //Action that runs when the user clicks the loginbutton
    @IBAction func loginButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // When view is loaded, the app asks autorization for Siri
        INPreferences.requestSiriAuthorization { (status) in
            
            // When given authorization, access allowed is printed
            if status == .authorized {
                print("Siri access allowed")
            }
                
                
                // When authorization is declined by user the console prints this text
            else {
                print("Siri access denied")
            }
            
            
        }
        
        // Static contacts in datamanager
        DataManager.sharedManager.saveContacts(contacts: [["name": "Rens", "number": "0623674821"], ["name": "Tim", "number": "0678123595"], ["name": "Xandor", "number": "0640209467"], ["name": "Steven", "number": "0653409248"]])
        
    }


}

