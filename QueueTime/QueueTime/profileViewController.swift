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
    
    //Outlets for the login screen
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var malefemaleTextField: UITextField!
    
    //Action that is carried out when the login button is pressed
    @IBAction func sendinfoButton(_ sender: Any) {
        
        //Action that is carried out when the login button is pressed
        let PeronsalinfoDB = Database.database().reference().child("Personalinfo")
        
        //Values ​​in the two text fields are added in Firebase database.
        let PeronsalinfoDictionary : NSDictionary = ["age" : malefemaleTextField.text!, "gender" : ageTextField.text!]
        PeronsalinfoDB.childByAutoId().setValue(PeronsalinfoDictionary) {
            (error, ref) in
            
            //Action has not been executed, and reports.
            if error != nil {
                print(error!)
                
                //Action has been successfully executed and reports.
            }
            else {
                print("Message saved successfully!")
            }
        }
        
    }
    
    //Do any additional setup after loading the view.
}



 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation

 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.

 





