//
//  ViewController.swift
//  Foursquare
//
//  Created by Cem Bıçakcı on 19.07.2023.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != ""{
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                if(error != nil){
                    self.makeAlert(titleInput: "Error", messageString: error?.localizedDescription ?? "Error")
                }else{
                    
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                    
                }
            }
            
        }else{
            self.makeAlert(titleInput: "Error", messageString: "Username/Password")
        }
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { success, error in
                if(error != nil){
                    self.makeAlert(titleInput: "Error", messageString: error?.localizedDescription ?? "Error")
                }else{
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
            }
            
        }else{
            makeAlert(titleInput: "Error", messageString: "Username/Password")
        }
        
    }
    
    func makeAlert(titleInput: String, messageString: String){
        let alert = UIAlertController(title: titleInput, message: messageString, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

