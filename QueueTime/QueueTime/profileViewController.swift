//
//  profileViewController.swift
//  QueueTime
//
//  Created by Xandor Naus on 14/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import UIKit

import Firebase

class profileViewController: UIViewController {
    
    //Outlets voor het loginscherm
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var malefemaleTextField: UITextField!
    
    //Actie die word uitgevoerd als er op de login button word gedrukt
    @IBAction func sendinfoButton(_ sender: Any) {
        
        
        var refArtists: DatabaseReference!
        
        func viewDidLoad() {
            super.viewDidLoad()
            // Voer een extra installatie uit nadat de weergave is geladen, meestal vanaf een punt.
            
            FirebaseApp.configure()
            
            // Een verwijzing naar de knooppuntartiesten krijgen
            refArtists = Database.database().reference().child("artists");
        
        func addInfo(){
            
            let key = refArtists.childByAutoId().key
            
            // Info aangemaakt met bijbehoorde values.
            let artist = ["id":key,
                          "age": ageTextField.text! as String,
                          "gender": malefemaleTextField.text! as String
            ]
            
            // De info een unieke key meegeven, voor desbetreffende user.
            refArtists.child(key).setValue(artist)
            
    
        
        }

        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //configuring firebase
        FirebaseApp.configure()
        
    }
    
    // Do any additional setup after loading the view.
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

}

