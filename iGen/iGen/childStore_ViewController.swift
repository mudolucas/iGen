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
    
    // HAT VARIABLES
    @IBOutlet weak var hatBuyButton: UIButton!
    @IBOutlet weak var hatButtonText: UILabel!
    let hatPrice = 30
    
    // MITTENS VARIABLES
    @IBOutlet weak var mittensBuyButton: UIButton!
    @IBOutlet weak var mittensButtonText: UILabel!
    let mittensPrice = 45
    
    // GLASSES VARIABLES
    @IBOutlet weak var glassesBuyButton: UIButton!
    @IBOutlet weak var glassesButtonText: UILabel!
    let glassesPrice = 60
    
    // MUSTACHE VARIABLES
    @IBOutlet weak var mustacheBuyButton: UIButton!
    @IBOutlet weak var mustacheButtonText: UILabel!
    let mustachePrice = 90
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWallet()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func mustacheClickButton(_ sender: Any) {
        mustacheButtonText.text = "Bought"
        mustacheBuyButton.isEnabled = false
        timeCoins -= glassesPrice
        childWallet.text = String(timeCoins)
        updateWallet()
    }
    
    @IBAction func glassesClickButton(_ sender: Any) {
        glassesButtonText.text = "Bought"
        glassesBuyButton.isEnabled = false
        timeCoins -= glassesPrice
        childWallet.text = String(timeCoins)
        updateWallet()
    }
    
    @IBAction func hatClickButton(_ sender: Any) {
        hatButtonText.text = "Bought"
        hatBuyButton.isEnabled = false
        timeCoins -= hatPrice
        childWallet.text = String(timeCoins)
        updateWallet()
    }
    
    @IBAction func mittensClickButton(_ sender: Any) {
        mittensButtonText.text = "Bought"
        mittensBuyButton.isEnabled = false
        timeCoins -= mittensPrice
        childWallet.text = String(timeCoins)
        updateWallet()
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
