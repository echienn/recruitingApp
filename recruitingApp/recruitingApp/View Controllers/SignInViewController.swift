//
//  SignInViewController.swift
//  recruitingApp
//
//  Created by Neha Kunjal on 12/4/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userEmail = ""
    var userPassword = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if(FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        return true
    }
    @IBAction func logInPressed(_ sender: UIButton) {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        if emailText == "" || passwordText == "" {
            let alertController = UIAlertController(title: "Log In Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().signIn(withEmail: emailText, password: passwordText, completion: { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "segueSignInToMainPage", sender: self)
                } else {
                    let alertController = UIAlertController(title: "Log in Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier:"segueLogInToCreateAccount", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        if(FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //if Auth.auth().currentUser != nil {
          //  self.performSegue(withIdentifier: "segueSignInToMainPage", sender: self)
        //}
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

