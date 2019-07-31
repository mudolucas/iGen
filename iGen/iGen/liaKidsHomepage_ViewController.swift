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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        childWalletAmount.text = String(timeCoins)
        
        // Alter text and size
        gamesLabel.font = gamesLabel.font.withSize(20)
        
    }
    


}
