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

    @IBOutlet weak var tommi: UIImageView!
    // Label for the timeCoins the kid has currently
    @IBOutlet weak var childWallet: UILabel!
    @IBOutlet weak var tommiSpeech: UILabel!
    
    var timeCoins = Int()
    var userRef: DatabaseReference?
    
    // HAT VARIABLES
    @IBOutlet weak var hatBuyButton: UIButton!
    @IBOutlet weak var hatButtonText: UILabel!
    let hatPrice = 30
    var hatBought = false
    var hatEquipped = false
    // MITTENS VARIABLES
    @IBOutlet weak var mittensBuyButton: UIButton!
    @IBOutlet weak var mittensButtonText: UILabel!
    let magicPrice = 35
    var magicBought = false
    var magicEquipped = false
    // GLASSES VARIABLES
    @IBOutlet weak var glassesBuyButton: UIButton!
    @IBOutlet weak var glassesButtonText: UILabel!
    let bowPrice = 40
    var bowBought = false
    var bowEquipped = false
    // MUSTACHE VARIABLES
    @IBOutlet weak var mustacheBuyButton: UIButton!
    @IBOutlet weak var mustacheButtonText: UILabel!
    let mustachePrice = 90
    var mustacheBought = false
    var mustacheEquppied = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getWallet()
    }
    
    @IBAction func mustacheClickButton(_ sender: Any) {
        if self.mustacheBought == false{
            mustacheButtonText.text = "Equip"
            timeCoins -= mustachePrice
            childWallet.text = String(timeCoins)
            updateWallet()
            self.mustacheBought = true
            tommiSpeech.text = "Yay a mustache!"
        }
        else{
            equipMustache()
        }
    }
    
    @IBAction func glassesClickButton(_ sender: Any) {
        if self.bowBought == false{
            glassesButtonText.text = "Equip"
            timeCoins -= bowPrice
            childWallet.text = String(timeCoins)
            updateWallet()
            self.bowBought = true
        }
        else{
            equipBow()
        }
    }
    
    @IBAction func hatClickButton(_ sender: Any) {
        if self.hatBought == false{
            hatButtonText.text = "Equip"
            timeCoins -= hatPrice
            childWallet.text = String(timeCoins)
            updateWallet()
            self.hatBought = true
            tommiSpeech.text = "Yay a Hat!"
        }
        else{
            equipHat()
        }
    }
    
    @IBAction func mittensClickButton(_ sender: Any) {
        if self.magicBought == false{
            mittensButtonText.text = "Equip"
            timeCoins -= magicPrice
            childWallet.text = String(timeCoins)
            updateWallet()
            self.magicBought = true
        }
        else{
            equipMagicianHat()
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
    
    func equipHat(){
        self.hatEquipped = true
        self.magicEquipped = false
        self.bowEquipped = false
        self.mustacheEquppied = false
        tommi.image = UIImage(named: "hatTommi-1.png")
    }

    func equipMagicianHat(){
        self.hatEquipped = false
        self.magicEquipped = true
        self.bowEquipped = false
        self.mustacheEquppied = false
        tommi.image = UIImage(named: "magicianTommi")
        tommiSpeech.text = "I feel magical!"
    }
    
    func equipMustache(){
        self.hatEquipped = false
        self.magicEquipped = false
        self.bowEquipped = false
        self.mustacheEquppied = true
        tommi.image = UIImage(named: "mustacheTommi-1")
        tommiSpeech.text = "My face feels furry!"
    }
    
    func equipBow(){
        self.hatEquipped = false
        self.magicEquipped = false
        self.bowEquipped = true
        self.mustacheEquppied = false
        tommi.image = UIImage(named: "bowTommi")
        tommiSpeech.text = "I feel pretty!"
    }
    // Update the firebase wallet amount
    func updateWallet() {
        self.userRef?.updateChildValues(["wallet": self.timeCoins])
    }
    
    
    

}
