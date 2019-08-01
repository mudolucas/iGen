//
//  childStore_ViewController.swift
//  iGen
//
//  Created by Lia Johansen on 8/1/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class childStore_ViewController: UIViewController {

    // Label for the timeCoins the kid has currently
    @IBOutlet weak var childWallet: UILabel!
    
    var timeCoins = Int()
    var userRef: DatabaseReference?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // Get the child's wallet amount
    func getWallet() {
        let ref = Database.database().reference()
        //let userID = Auth.auth().currentUser?.uid
        let userID:String? = "IVDw4blq8qgyJ6fKQxDoVb9h6YZ2"
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? [String:Any]{
                if let wallet = value["wallet"] as? Int{
                    self.timeCoins = wallet
                }
                self.childWallet.text = String(self.timeCoins)
            }
            self.userRef = snapshot.ref

        }) { (error) in
            print(error.localizedDescription)
        }
    }

    // Update the firebase wallet amount
    func updateWallet() {
        self.userRef?.updateChildValues(["wallet": self.timeCoins])
    }
    
    
    

}
