//
//  loginViewController.swift
//  QueueTime
//
//  Created by Ivo van der Zee on 13/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import FacebookCore
import FacebookLogin


class loginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    //Functie die ervoor zorgt dat het account verbonden word met de Firebase database
    fileprivate func signIntoFirebase() {
        guard let authenticationToken = AccessToken.current?.authenticationToken else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
        Auth.auth().signIn(with: credential) { (user, err) in
            if let err = err {
                
                print(err)
            
            }
            print("Succesfully authenticated with Firebase.")
            
        }
    }
    
    
    
    //Functie die word uitgevoerd wanneer er op de Facebooklogin button word geklikt
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            
            print(error)
            return
            
        }
        
        print ("login via facebook gelukt!")
        self.signIntoFirebase()
    }
    
    
    //Functie die word uitgevoerd wanneer er word uitgelogd bij facebook
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("uitgelogd bij Facebook")
        
        
        
        
        
    }
    

    
    //Outlets voor het loginscherm
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var facebookLoginOutlet: UIButton!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Button van facebook word aangemaakt
        let facebook = FBSDKLoginButton()
        view.addSubview(facebook)
        
        //Facebookbutton word toegevoegd aan de view
        facebook.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        
        facebook.delegate = self
        
        //Email adres en het profiel worden opgehaald en in firebase gezet
        facebook.readPermissions = ["email", "public_profile"]
        
    
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 99
        profileImage.layer.borderWidth = 5
        profileImage.layer.borderColor = UIColor.black.cgColor
        
        username.layer.masksToBounds = true
        username.layer.cornerRadius = 3
        username.layer.borderWidth = 1
        username.layer.borderColor = UIColor.black.cgColor
        
        password.layer.masksToBounds = true
        password.layer.cornerRadius = 3
        password.layer.borderWidth = 1
        password.layer.borderColor = UIColor.black.cgColor
        
        
        
    }
    
    
    @IBAction func facebookLogin(_ sender: Any) {
        
    }
    
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
