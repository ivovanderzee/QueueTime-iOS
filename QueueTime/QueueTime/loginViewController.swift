//
//  loginViewController.swift
//  QueueTime
//
//  Created by Ivo van der Zee on 13/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//


//Libraries that are used in this viewcontroller
import UIKit
import FirebaseAuth
import FBSDKLoginKit
import FacebookCore
import FacebookLogin


//Library for siri integration
import Intents




class loginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    //Function that connects the facebook acccount to the firebase database
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
    
    
    
    //Function that runs when the user clicks the facebooklogin button
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            
            print(error)
            return
            
        }
        
        //The segue "login" activates when the facebooklogin is succeeded
          self.performSegue(withIdentifier: "login", sender: self)
        print ("login via facebook gelukt!")
        self.signIntoFirebase()
      
    }
    
    
    //Function that logs the user out
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("uitgelogd bij Facebook")
        
    }
    

    
    //Outlets for the loginscreen
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    
    
    //This code runs when the whole view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The app ask if it can use Siri
        INPreferences.requestSiriAuthorization { (status) in
            
            if status == .authorized {
                print("Siri access allowed")
            }
                
            else {
                print("Siri access denied")
            }
            
            
            
            
        }
        
    
      
        
        //Button for the facebook login is created
        let facebook = FBSDKLoginButton()
        //This code adds the button to the main view
        view.addSubview(facebook)
        
        //Facebookbutton gets in shape
        facebook.frame = CGRect(x: 19, y: 620, width: 375, height: 50)
        
        
        
        facebook.delegate = self
        
        //This code provides the app can read the email adress and public profile name
        facebook.readPermissions = ["email", "public_profile"]
        
    
        //The elements in the screen are getting in shape (cornerRadius)
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
    
   
    

    
    
    //Code that runs when the user clicks the loginButton
    @IBAction func loginButton(_ sender: Any) {
        
        
        //The user can login with the username and password that are typed in the outlets
        Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (user, error) in
            if user != nil{
                
                
                //The segue "login" is activated when the username and password are correct
                self.performSegue(withIdentifier: "login", sender: self)
            }
            else{
                
                
                //When the login fails, a pop-up appeared in the screen
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
    
    
    //function that hides the keyboard when the user clicks on a random spot in the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
