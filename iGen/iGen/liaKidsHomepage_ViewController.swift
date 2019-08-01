//
//  liaKidsHomepage_ViewController.swift
//  iGen
//
//  Created by Lia Johansen on 7/31/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit

class liaKidsHomepage_ViewController: UIViewController {

    let DECREASE_TIME_COINS = 5
    let INCREASE_CATEGORY_TIME = 5.0
    

    // ***** COINS VARIABLES ****
    // Label for the coins
    @IBOutlet weak var childWalletAmount: UILabel!
    // Total number of coins they currently have
    var timeCoins = 12
    
    
    // ***** GAMES VARIABLES ******
    // NEED TO GRAB FROM FIREBASE
    var currentGameTime = 30.0
    var maxGameTime = 60.0
    @IBOutlet weak var gamesLabel: UILabel!
    @IBOutlet weak var gameStatusBar: UIProgressView!
    @IBOutlet weak var timeLeftGamesLabel: UILabel!
    @IBOutlet weak var gameIncreaseBUTTON: UIButton!
    
    
    // ***** EDUCATION VARIABLES ******
    var currentEducationTime = 10.0
    var maxEducationTime = 90.0
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var educationStatusBar: UIProgressView!
    @IBOutlet weak var timeLeftEducationLabel: UILabel!
    @IBOutlet weak var educationIncreaseBUTTON: UIButton!
    
    
    // ***** PRODUCTIVITY VARIABLES *****
    var currentProductivityTime = 0.0
    var maxTime = -10.0
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the size of the status bars
        gameStatusBar.transform = gameStatusBar.transform.scaledBy(x: 1, y: 10)
        educationStatusBar.transform = educationStatusBar.transform.scaledBy(x: 1, y: 10)
        
        // Setting up the font size of category labels
        gamesLabel.font = gamesLabel.font.withSize(20)
        educationLabel.font = educationLabel.font.withSize(20)
        
        // Setting up the kids wallet viewing
        childWalletAmount.text = String(timeCoins)
        
        
        // SETTING UP THE GAMES CATEGORY
        if (maxGameTime == -1.0) {
            gameIncreaseBUTTON.isHidden = true;
            gameSetupHelper(1.0, "Unlimited")
            
        } else if (maxGameTime == -10.0) {
            gameIncreaseBUTTON.isHidden = true;
            gameSetupHelper(0.0, "Blocked")
        } else {
            gameSetupHelper((currentGameTime / maxGameTime), String(toInt(currentGameTime)))
        }
        
        // SETTING UP THE EDUCATION CATEGORY
        if (maxEducationTime == -1.0) {
            educationIncreaseBUTTON.isHidden = true;
            educationSetupHelper(1.0, "Unlimited")
            
        } else if (maxEducationTime == -10.0) {
            educationIncreaseBUTTON.isHidden = true;
            educationSetupHelper(0.0, "Blocked")
        } else {
            educationSetupHelper((currentEducationTime / maxEducationTime), String(toInt(currentEducationTime)))
        }
        
        // SETTING UP THE PRODUCTIVITY CATEGORY
        
        
        
        
    }
    
    func gameSetupHelper (_ progress: Double, _ text: String) {
        gameStatusBar.progress = Float(progress)
        timeLeftGamesLabel.text = text
    }
    
    func educationSetupHelper(_ progress: Double, _ text: String) {
        educationStatusBar.progress = Float(progress)
        timeLeftEducationLabel.text = text
    }
    
    
    
    
    @IBAction func increaseGameTime(_ sender: UIButton) {
        
        if (timeCoins - DECREASE_TIME_COINS < 0) { // Not enough coins
            // Throw alert that child doesnt have enough time coins
            alertChildCoins()
        } else if (currentGameTime + INCREASE_CATEGORY_TIME > maxGameTime) {
            alertChildFull()
        } else { // Has enough coins and time isnt full
            // 1: Decrease coins by 5
            timeCoins -= DECREASE_TIME_COINS
            // 2: Show the new coin amount
            childWalletAmount.text = String(timeCoins)
            // 3: Increase the time
            currentGameTime = currentGameTime + INCREASE_CATEGORY_TIME
            // 4: Update the progress bar
            gameStatusBar.setProgress(Float(currentGameTime / maxGameTime), animated: true)
            // 5: Update the amount of time left
            timeLeftGamesLabel.text = String(toInt(currentGameTime))
        }
    }
    
    
    @IBAction func increaseEducationTime(_ sender: Any) {
        if (timeCoins - DECREASE_TIME_COINS < 0) { // Not enough coins
            // Throw alert that child doesnt have enough time coins
            alertChildCoins()
        } else if (currentGameTime + INCREASE_CATEGORY_TIME > maxGameTime) {
            alertChildFull()
        } else { // Has enough coins and time isnt full
            // 1: Decrease coins by 5
            timeCoins -= DECREASE_TIME_COINS
            // 2: Show the new coin amount
            childWalletAmount.text = String(timeCoins)
            // 3: Increase the time
            currentEducationTime = currentEducationTime + INCREASE_CATEGORY_TIME
            // 4: Update the progress bar
            educationStatusBar.setProgress(Float(currentEducationTime / maxEducationTime), animated: true)
            // 5: Update the amount of time left
            timeLeftEducationLabel.text = String(toInt(currentEducationTime))
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
    
    
    // Takes in a double and returns it to an int
    func toInt (_ number: Double) -> Int {
        return Int(number)
    }
    
    
    // Takes in an int and returns it to a double
    func toDouble(_ number: Int) -> Double {
        return Double(number)
    }
    
    
    
}
