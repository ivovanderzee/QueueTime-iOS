//
//  signUpViewController.swift
//  
//
//  Created by Ivo van der Zee on 13/11/2018.
//


//All the libraries that are used in this viewcontroller
import UIKit
import FirebaseAuth

class signUpViewController: UIViewController {
    
    //Outlets on the SignUpViewController
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    
    //This code runs when the user clicks on the signUpButton
    @IBAction func signUpButton(_ sender: Any) {
        
        
        //Function that creates an user in the Firebase database
        
        //The password and username are equal to the textfields that are connected to the outlets
        Auth.auth().createUser(withEmail: username.text!, password: password.text!) { (user, error) in
            if user != nil
            {
                print("gebruiker aangemaakt")
                
                //When the signUp succeeded, the user returns to the loginscreen. The segue goToLogin is activated
                self.performSegue(withIdentifier: "goToLogin", sender: self)
                
            }
                
                //When the signup fails, the console prints this text
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
