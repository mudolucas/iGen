//
//  ViewController.swift
//  iGen
//
//  Created by Lucas Mudo de Araujo on 7/19/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import FirebaseAnalytics

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    
    var ref: DatabaseReference?
    
    @IBAction func pressCreateAccount(_ sender: Any) {
    }
    
    @IBAction func pressLogin(_ sender: Any) {
    }

    
    @IBAction func createAccountAction(_ sender: Any) {

        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "questTest")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        if loginEmail.text == nil || loginPassword.text == nil {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: loginEmail.text!, password: loginPassword.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "questTest")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                
  
                }
            }
        }
    }
    
    @IBAction func setPinPressed(_ sender: Any) {
        if (pinTextField.text == nil || pinTextField.text?.count != 4) {
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            let alertController = UIAlertController(title: "Error", message: "Please enter a 4 digit pin.", preferredStyle: .alert)
                
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
                
            self.present(alertController, animated: true, completion: nil)
        } else {
            ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            let userEmail = Auth.auth().currentUser?.email
            let pin = pinTextField.text
            self.ref?.child("users/\(userID!)/pin").setValue(pin)
            self.ref?.child("users/\(userID!)/email").setValue(userEmail)
            self.ref?.child("users/\(userID!)/uid").setValue(userID)
            self.ref?.child("users/\(userID!)/quests").setValue([""])
            self.ref?.child("users/\(userID!)/parentMode").setValue(true)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Quests.loadAllQuestsForUser()
        // Do any additional setup after loading the view.
    }

}

