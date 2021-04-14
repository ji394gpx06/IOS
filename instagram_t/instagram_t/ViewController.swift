//
//  ViewController.swift
//  instagram_t
//
//  Created by RuiJun haung on 2021/3/25.
//

import UIKit
import Parse
class ViewController: UIViewController {

    var signupModeActive = true
    func displayAlert( title:String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signOrLogin(_ sender: Any) {
        
        if email.text == "" || password.text == ""{
            
            displayAlert(title: "Error in form", message: "Please enter an email and password")
            
           
        }else{
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.medium
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            if(signupModeActive){
                print("Signing up....")
                let user = PFUser()
                user.username = email.text
                user.password = password.text
                user.email = email.text
                user.signUpInBackground(block: { (success, error) in
                    activityIndicator.stopAnimating()
                    if let error = error{
                        self.displayAlert(title: "Could not sign you up", message: error.localizedDescription)
                        print(error)
                        
                        
                    }else{
                        
                        print("signed up!")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                
                
                })
            }else{
                PFUser.logInWithUsername(inBackground: email.text!, password: password.text!) { (user, error) in
                    if user != nil{
                        
                        print("Login successful")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }else{
                        
                        var errorText = "Unkown error:Please try again"
                        if let error = error{
                            
                            errorText = error.localizedDescription
                        }
                        self.displayAlert(title: "Could not sign you up", message: errorText)
                        
                    }
                }
                
                
                
                
            }
            
        }
    }
    
    
    
    @IBOutlet weak var signupOrLoginButton: UIButton!
    @IBAction func swichLoginMode(_ sender: Any) {
        if(signupModeActive){
            
            signupModeActive = false
            signupOrLoginButton.setTitle("Log In", for: [])
            switchLoginModeButton.setTitle("Sign Up", for: [])
            
            
        }else{
            
            signupModeActive = true
            signupOrLoginButton.setTitle("Sign Up", for: [])
            switchLoginModeButton.setTitle("Log In", for: [])
            
            
            
        }
        
    }
    
    
    @IBOutlet weak var switchLoginModeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       /*
        let comment = PFObject(className: "Comment")
        comment["text"] = "Nice shot!"
        comment.saveInBackground{(success,error) in
            if(success){
                print("Save successful")
                
            }else{
                
                print("Save failed")
                
            }
            
            
        }
         */
        
            
            
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            
            performSegue(withIdentifier: "showUserTable", sender: self)
            
        }
        self.navigationController?.navigationBar.isHidden = true
    }

}

