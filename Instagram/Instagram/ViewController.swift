//
//  ViewController.swift
//  Instagram
//
//  Created by Cem Bıçakcı on 16.07.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Eğer giriş yapan bir kullanıcı varsa, güncel kullanıcıyı alabiliriz.
        //SceneDelegate kısmından, kodla açılış ekranını değiştirebiliyoruz.
    }


    @IBAction func signInClicked(_ sender: Any) {
        
        if(emailText.text != "" && passwordText.text != ""){
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                if(error != nil){
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(titleInput: "Error", messageInput: "Username/Password")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if(emailText.text != "" && passwordText.text != ""){
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                if(error != nil){
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else{
           makeAlert(titleInput: "Error", messageInput: "Username/Password")
        }
        
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

