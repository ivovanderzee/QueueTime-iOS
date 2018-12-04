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
import Intents




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
        
          self.performSegue(withIdentifier: "login", sender: self)
        print ("login via facebook gelukt!")
        self.signIntoFirebase()
      
    }
    
    
    //Functie die word uitgevoerd wanneer er word uitgelogd bij facebook
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("uitgelogd bij Facebook")
        
        self.performSegue(withIdentifier: "login", sender: self)
    }
    

    
    //Outlets voor het loginscherm
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    
    
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
        
    
      
        
        //Button van facebook word aangemaakt
        let facebook = FBSDKLoginButton()
        view.addSubview(facebook)
        
        //Facebookbutton word toegevoegd aan de view
        facebook.frame = CGRect(x: 19, y: 620, width: 375, height: 50)
        
        
        
        facebook.delegate = self
        
        //Email adres en het profiel worden opgehaald en in firebase gezet
        facebook.readPermissions = ["email", "public_profile"]
        
    
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 117
        
        
        username.layer.masksToBounds = true
        username.layer.cornerRadius = 20
     
        username.layer.backgroundColor = UIColor.white.cgColor
        
        password.layer.masksToBounds = true
        password.layer.cornerRadius = 20
       
        password.layer.backgroundColor = UIColor.white.cgColor
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 3
        
        topView.layer.masksToBounds = true
        topView.layer.cornerRadius = 385
        
       
    
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
