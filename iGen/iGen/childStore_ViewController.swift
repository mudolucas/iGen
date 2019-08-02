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
    var hatBought = false
    
    // MITTENS VARIABLES
    @IBOutlet weak var mittensBuyButton: UIButton!
    @IBOutlet weak var mittensButtonText: UILabel!
    let mittensPrice = 45
    var mittensBought = false
    // GLASSES VARIABLES
    @IBOutlet weak var glassesBuyButton: UIButton!
    @IBOutlet weak var glassesButtonText: UILabel!
    let glassesPrice = 60
    var glassesBought = false
    // MUSTACHE VARIABLES
    @IBOutlet weak var mustacheBuyButton: UIButton!
    @IBOutlet weak var mustacheButtonText: UILabel!
    let mustachePrice = 90
    var mustacheBought = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Tommi's Store"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getWallet()
    }
    
    @IBAction func mustacheClickButton(_ sender: Any) {
        if self.mustacheBought == false{
            mustacheButtonText.text = "Equip"
            timeCoins -= glassesPrice
            childWallet.text = String(timeCoins)
            updateWallet()
            self.mustacheBought = true
        }
        else{
            //equipMustache()
        }
    }
    
    @IBAction func glassesClickButton(_ sender: Any) {
        if self.glassesBought == false{
            glassesButtonText.text = "Equip"
            timeCoins -= glassesPrice
            childWallet.text = String(timeCoins)
            updateWallet()
            self.glassesBought = true
        }
        else{
            //equipGlasses()
        }
    }
    
    @IBAction func hatClickButton(_ sender: Any) {
        if self.hatBought == false{
            hatButtonText.text = "Equip"
            timeCoins -= hatPrice
            childWallet.text = String(timeCoins)
            updateWallet()
            self.hatBought = true
        }
        else{
            //equipHat()
        }
    }
    
    @IBAction func mittensClickButton(_ sender: Any) {
        if self.mittensBought == false{
            mittensButtonText.text = "Equip"
            timeCoins -= mittensPrice
            childWallet.text = String(timeCoins)
            updateWallet()
            self.mittensBought = true
        }
        else{
            //equipMittens
        }
    }
    
    
    // Get the child's wallet amount
    func getWallet() {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        //let userID:String? = "IVDw4blq8qgyJ6fKQxDoVb9h6YZ2"
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
