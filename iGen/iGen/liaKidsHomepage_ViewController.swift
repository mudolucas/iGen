//
//  liaKidsHomepage_ViewController.swift
//  iGen
//
//  Created by Lia Johansen on 7/31/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class liaKidsHomepage_ViewController: UIViewController {

    let DECREASE_INCREASE_TIME_COINS = 5
    

    // ***** COINS VARIABLES ****
    // Label for the coins
    @IBOutlet weak var childWalletAmount: UILabel!
    // Total number of coins they currently have
    var timeCoins = Int()
    var userRef: DatabaseReference?
    
    
    // ***** GAMES VARIABLES ******
    // NEED TO GRAB FROM FIREBASE
    var currentGameTime = 30
    var maxGameTime = Int()
    @IBOutlet weak var gamesLabel: UILabel!
    @IBOutlet weak var gameStatusBar: UIProgressView!
    @IBOutlet weak var timeLeftGamesLabel: UILabel!
    @IBOutlet weak var gameIncreaseBUTTON: UIButton!
    @IBOutlet weak var minutesLeftGameLABEL: UILabel!
    
    
    // ***** EDUCATION VARIABLES ******
    var currentEducationTime = 10
    var maxEducationTime = Int()
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var educationStatusBar: UIProgressView!
    @IBOutlet weak var timeLeftEducationLabel: UILabel!
    @IBOutlet weak var educationIncreaseBUTTON: UIButton!
    @IBOutlet weak var minutesLeftEducationLABEL: UILabel!
    
    
    // ***** PRODUCTIVITY VARIABLES *****
    var currentProductivityTime = 10
    var maxProductivityTime = Int()
    @IBOutlet weak var productivityLabel: UILabel!
    @IBOutlet weak var productivityStatusBar: UIProgressView!
    @IBOutlet weak var timeLeftProductivityLabel: UILabel!
    @IBOutlet weak var productivityIncreaseBUTTON: UIButton!
    @IBOutlet weak var minutesLeftProductivityLABEL: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Setting the size of the status bars
        gameStatusBar.transform = gameStatusBar.transform.scaledBy(x: 1, y: 10)
        educationStatusBar.transform = educationStatusBar.transform.scaledBy(x: 1, y: 10)
        productivityStatusBar.transform = productivityStatusBar.transform.scaledBy(x: 1, y: 10)
        
        // Setting up the font size of category labels
        gamesLabel.font = gamesLabel.font.withSize(20)
        educationLabel.font = educationLabel.font.withSize(20)
        productivityLabel.font = productivityLabel.font.withSize(20)
        
        // Setting up the kids wallet
        getWallet() // Get from firebase
        
        // Get the category time limits
        getCategoryTime() // Get from firebase
        
        
        
        
    }
    
    func gameSetupHelper (_ progress: Double, _ text: String) {
        gameStatusBar.progress = Float(progress)
        timeLeftGamesLabel.text = text
    }
    
    func educationSetupHelper(_ progress: Double, _ text: String) {
        educationStatusBar.progress = Float(progress)
        timeLeftEducationLabel.text = text
    }
    
    func productivitySetupHelper(_ progress: Double, _ text: String) {
        productivityStatusBar.progress = Float(progress)
        timeLeftProductivityLabel.text = text
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
            self.childWalletAmount.text = String(self.timeCoins)
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
    
    // Get the app category times --> Call in the init
    func getCategoryTime() {
        let ref = Database.database().reference().child("CategoryLimits")
        //let userID = Auth.auth().currentUser?.uid
        let userID:String? = "IVDw4blq8qgyJ6fKQxDoVb9h6YZ2"
        let query = ref.queryOrdered(byChild: "uid").queryEqual(toValue: userID)
        query.observe(.value) { (snapshot) in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    if let newLoadTimes = AppTimeSet(snapshot: snapshot) as? AppTimeSet{
                        self.maxGameTime = newLoadTimes.gameLimitInt
                        self.maxEducationTime = newLoadTimes.educationLimitInt
                        self.maxProductivityTime = newLoadTimes.productivityLimitInt
                    }
                    
                    // SETTING UP THE GAMES CATEGORY
                    if (self.maxGameTime == -1) {
                        self.gameIncreaseBUTTON.isHidden = true;
                        self.minutesLeftGameLABEL.isHidden = true;
                        self.gameSetupHelper(1.0, "Unlimited")
                        
                    } else if (self.maxGameTime == -10) {
                        self.gameIncreaseBUTTON.isHidden = true;
                        self.minutesLeftGameLABEL.isHidden = true;
                        self.gameSetupHelper(0.0, "Blocked ❌")
                    } else {
                        self.gameSetupHelper((Double(self.currentGameTime) / Double(self.maxGameTime)), String(self.currentGameTime))
                    }
                    
                    // SETTING UP THE EDUCATION CATEGORY
                    if (self.maxEducationTime == -1) {
                        self.educationIncreaseBUTTON.isHidden = true;
                        self.minutesLeftEducationLABEL.isHidden = true;
                        self.educationSetupHelper(1.0, "Unlimited ♾")
                        
                    } else if (self.maxEducationTime == -10) {
                        self.educationIncreaseBUTTON.isHidden = true;
                        self.minutesLeftEducationLABEL.isHidden = true;
                        self.educationSetupHelper(0.0, "Blocked ❌")
                    } else {
                       self.educationSetupHelper((Double(self.currentEducationTime) / Double(self.maxEducationTime)), String(self.currentEducationTime))
                    }
                    
                    // SETTING UP THE PRODUCTIVITY CATEGORY
                    if (self.maxProductivityTime == -1) {
                        self.productivityIncreaseBUTTON.isHidden = true;
                        self.minutesLeftProductivityLABEL.isHidden = true;
                        self.productivitySetupHelper(1.0, "Unlimited ♾")
                        
                    } else if (self.maxProductivityTime == -10) {
                        self.productivityIncreaseBUTTON.isHidden = true;
                        self.minutesLeftProductivityLABEL.isHidden = true;
                        self.productivitySetupHelper(0.0, "Blocked ❌")
                    } else {
                        self.productivitySetupHelper((Double(self.currentProductivityTime) / Double(self.maxProductivityTime)), String(self.currentProductivityTime))
                    }
                    
                    print("game max time: \(self.maxGameTime)")
                    print("education max time: \(self.maxEducationTime)")
                    print("productivity max time: \(self.maxProductivityTime)")
                }
            }
        }
    }
    
    
    

    @IBAction func increaseGameTime(_ sender: UIButton) {
        
        if (timeCoins - DECREASE_INCREASE_TIME_COINS < 0) { // Not enough coins
            // Throw alert that child doesnt have enough time coins
            alertChildCoins()
        } else if (currentGameTime + DECREASE_INCREASE_TIME_COINS > maxGameTime) {
            alertChildFull()
        } else { // Has enough coins and time isnt full
            // 1: Decrease coins by 5
            timeCoins -= DECREASE_INCREASE_TIME_COINS
            updateWallet()
            // 2: Show the new coin amount
            childWalletAmount.text = String(timeCoins)
            // 3: Increase the time
            currentGameTime = currentGameTime + DECREASE_INCREASE_TIME_COINS
            // 4: Update the progress bar
            gameStatusBar.setProgress(Float(Double(currentGameTime) / Double(maxGameTime)), animated: true)
            // 5: Update the amount of time left
            timeLeftGamesLabel.text = String(currentGameTime)
        }
    }
    
    
    @IBAction func increaseEducationTime(_ sender: Any) {
        if (timeCoins - DECREASE_INCREASE_TIME_COINS < 0) { // Not enough coins
            // Throw alert that child doesnt have enough time coins
            alertChildCoins()
        } else if (currentEducationTime + DECREASE_INCREASE_TIME_COINS > maxEducationTime) {
            alertChildFull()
        } else { // Has enough coins and time isnt full
            // 1: Decrease coins by 5
            timeCoins -= DECREASE_INCREASE_TIME_COINS
            updateWallet()
            // 2: Show the new coin amount
            childWalletAmount.text = String(timeCoins)
            // 3: Increase the time
            currentEducationTime = currentEducationTime + DECREASE_INCREASE_TIME_COINS
            // 4: Update the progress bar
            educationStatusBar.setProgress(Float(Double(currentEducationTime) / Double(maxEducationTime)), animated: true)
            // 5: Update the amount of time left
            timeLeftEducationLabel.text = String(currentEducationTime)
        }
    }
    
    
    @IBAction func increaseProductivityTime(_ sender: Any) {
        if (timeCoins - DECREASE_INCREASE_TIME_COINS < 0) { // Not enough coins
            // Throw alert that child doesnt have enough time coins
            alertChildCoins()
        } else if (currentProductivityTime + DECREASE_INCREASE_TIME_COINS > maxProductivityTime) {
            alertChildFull()
        } else { // Has enough coins and time isnt full
            // 1: Decrease coins by 5
            timeCoins -= DECREASE_INCREASE_TIME_COINS
            updateWallet()
            // 2: Show the new coin amount
            childWalletAmount.text = String(timeCoins)
            // 3: Increase the time
            currentProductivityTime = currentProductivityTime + DECREASE_INCREASE_TIME_COINS
            // 4: Update the progress bar
            productivityStatusBar.setProgress(Float(Double(currentProductivityTime) / Double(maxProductivityTime)), animated: true)
            // 5: Update the amount of time left
            timeLeftProductivityLabel.text = String(currentProductivityTime)
        }
    }
    
    
    
    // ******
    // HELPER METHODS
    // *****
    
    
    // Function to alert the child that their time is already full
    func alertChildFull() {
        // create the alert
        let alert = UIAlertController(title: "Time is already full", message: "No more time to get!", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // Function to alert child that they are out of coins
    func alertChildCoins() {
        // create the alert
        let alert = UIAlertController(title: "Oh no! Out of time coins", message: "Go check your quests to earn more time coins!!!", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
