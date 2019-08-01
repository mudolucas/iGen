//
//  settingsKidMode.swift
//  iGen
//
//  Created by Vivian Hua on 7/30/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class settingsKidMode: UIViewController {

    @IBOutlet weak var kidSwitch: UISwitch!
    
    var userDictionary : [String:Any]!
    var ref : DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    var parentPin : String!
    var kidMode : Bool?
    private var userReference: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPinCode()
        ref = Database.database().reference()
        ref.child("users")
            .queryOrdered(byChild: "uid")
            .queryEqual(toValue: userID)
            .observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
                for userChild in snapshot.children {
                    if let userSnapshot = userChild as? DataSnapshot {
                        self.userDictionary = userSnapshot.value as? [String:Any]
                        self.kidSwitch.setOn(self.userDictionary["kidMode"] as! Bool, animated: true)
                    }
                }
            })
    }
    
    @IBAction func kidSwitchedPressed(_ sender: Any) {
        if kidMode as! Bool == true {
            let alert = UIAlertController(
                title: "Enter PIN",
                message: "Switch to Parent Mode",
                preferredStyle: .alert)
            
            // Add a text field to the alert for the new item's title
            alert.addTextField { (textField: UITextField) in
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .default
                textField.placeholder = "PIN"
                textField.isSecureTextEntry = true
                textField.textAlignment = .center
                textField.clearButtonMode = .whileEditing
            }
            
            // Add a "cancel" button to the alert. This one doesn't need a handler
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                self.kidSwitch.setOn(true, animated: true)
            }))
            
            // Add a "OK" button to the alert. The handler calls addNewToDoItem()
            alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (_) in
                if let inputedPin = alert.textFields?[0].text as? String {
                    if inputedPin == self.parentPin{
                        self.kidSwitch.setOn(false, animated: true)
                        self.updateUserDictionary(false)
                    } else {
                        self.kidSwitch.setOn(true, animated: true)
                    }
                }
            }))
            // Present the alert to the user
            self.present(alert, animated: true, completion: nil)
        } else {
            updateUserDictionary(true)
        }
    }
    
    
    private func updateUserDictionary(_ mode: Bool) {
        userReference?.updateChildValues(["kidMode":mode])
        getPinCode()
    }
    
    private func getPinCode(){
        let ref = Database.database().reference()
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var loadedPin:String=""
            if let value = snapshot.value as? [String:Any]{
                if let pin = value["pin"] as? String{
                    loadedPin = pin
                }
                if let kidMode = value["kidMode"] as? Bool{
                    self.kidMode = kidMode
                }
                self.userReference = snapshot.ref
            }
            self.parentPin = loadedPin
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
