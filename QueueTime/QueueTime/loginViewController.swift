//
//  loginViewController.swift
//  QueueTime
//
//  Created by Ivo van der Zee on 13/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import UIKit
import FirebaseAuth

class loginViewController: UIViewController {

    
    //Outlets voor het loginscherm
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    //Actie die word uitgevoerd als er op de login button word gedrukt
    @IBAction func loginButton(_ sender: Any) {
        
        
        //Functie waarmee de gebruiker kan inloggen met de ingevoerde gegevens
        Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (user, error) in
            if user != nil{
                
                
                //De segue "login" word uitgevoerd wanneer de ingevoerde gegevens kloppen
                self.performSegue(withIdentifier: "login", sender: self)
            }
            else{
                
                
                //De gebruiker krijgt een alert te zien wanneer het inloggen is mislukt
                let alert = UIAlertController(title: "Er heeft zich een probleem voorgedaan", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
