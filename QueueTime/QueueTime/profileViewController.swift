//
//  profileViewController.swift
//  QueueTime
//
//  Created by Xandor Naus on 14/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//


import UIKit

import Firebase

let ref = Database.database().reference(withPath: "Personalinfo")

class profileViewController: UIViewController {
    
    //Outlets voor het loginscherm
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var malefemaleTextField: UITextField!
    
    //Actie die word uitgevoerd als er op de login button word gedrukt
    @IBAction func sendinfoButton(_ sender: Any) {
        
        //Actie die word uitgevoerd als er op de login button word gedrukt
        let PeronsalinfoDB = Database.database().reference().child("Personalinfo")
        
        // Values die in de twee textvelden staan worden toegevoegd in Firebase-database.
        let PeronsalinfoDictionary : NSDictionary = ["age" : malefemaleTextField.text!, "gender" : ageTextField.text!]
        PeronsalinfoDB.childByAutoId().setValue(PeronsalinfoDictionary) {
            (error, ref) in
            
            // Actie is niet uitgevoerd, en geeft melding.
            if error != nil {
                print(error!)
                
                // Actie is succesfully uitgevoerd, en geeft melding.
            }
            else {
                print("Message saved successfully!")
            }
        }
        
    }
    
    // Do any additional setup after loading the view.
}



 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation

 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.

 





