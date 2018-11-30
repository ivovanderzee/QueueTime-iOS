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
            
        }
        INVocabulary.shared().setVocabularyStrings(["push up", "sit up", "pull up"], of: .workoutActivityName)
    }
    

}
