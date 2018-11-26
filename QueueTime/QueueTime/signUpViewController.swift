//
//  signUpViewController.swift
//  
//
//  Created by Ivo van der Zee on 13/11/2018.
//

import UIKit
import FirebaseAuth

class signUpViewController: UIViewController {
    
    //Outlets op het aanmeldscherm
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    
    //Actie die plaatsvind als de gebruiker zich wilt aanmelden
    @IBAction func signUpButton(_ sender: Any) {
        
        
        //Een functie die een gebruiker aanmaakt in de firebase database
        
        //Functie waarbij de username en password vanuit het textfield worden gehaald
        Auth.auth().createUser(withEmail: username.text!, password: password.text!) { (user, error) in
            if user != nil
            {
                print("gebruiker aangemaakt")
                
                //Wanneer het aanmelden is mislukt word de segue "goToLogin uitgevoerd"
                self.performSegue(withIdentifier: "goToLogin", sender: self)
                
            }
            else{
                print("Aanmelden.exe is onverwacht gestopt met werken")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Function for showing introduction screens for one time
    // TIM
    override func viewDidAppear(_ animated: Bool) {
        /*
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough")
        {
            return
        }*/
        let storyboard = UIStoryboard(name: "onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "walkthroughViewController") as? walkthroughViewController
        {
            present(walkthroughViewController, animated: true, completion: nil)
        }
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
