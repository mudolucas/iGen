//
//  AppTimeSet.swift
//  iGen
//
//  Created by Daniel Molina on 7/29/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import Foundation

import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


class AppTimeSet{
    var gameLimit: String
    var educationLimit: String
    var productivityLimit: String
    var gameLimitInt: Int
    var educationLimitInt: Int
    var productivityLimitInt: Int
    let limitRef: DatabaseReference?
    private var ref: DatabaseReference?
    init(gameLimit: String, educationLimit: String, productivityLimit: String) {
        self.gameLimit = gameLimit
        self.educationLimit = educationLimit
        self.productivityLimit = productivityLimit
        self.limitRef = nil
        self.gameLimitInt = 0
        self.educationLimitInt = 0
        self.productivityLimitInt = 0
    }
    
    init?(snapshot: DataSnapshot){
        guard
            let savedLimits = snapshot.value as?[String: AnyObject],
            let gameLimit: String = savedLimits["GameLimits"] as? String,
            let educationLimit: String = savedLimits["EducationLimits"] as? String,
            let productivityLimit: String = savedLimits["ProductivityLimits"] as? String else{
                return nil
        }
        self.limitRef = snapshot.ref
        self.gameLimit = gameLimit
        self.educationLimit = educationLimit
        self.productivityLimit = productivityLimit
    }
    
    func changeGameLimit(newGameLimit: String){
        self.gameLimit = newGameLimit
        let limit = newGameLimit.prefix(2)
        let lim = Int(limit)
        self.gameLimitInt = lim!
    }
    
    func changeEducationLimit(newEducationLimit: String){
        self.educationLimit = newEducationLimit
        let limit = newEducationLimit.prefix(2)
        let lim = Int(limit)
        self.educationLimitInt = lim!
    }
    
    func changeProductivityLimit(newProdcutivityLimit: String){
        self.productivityLimit = newProdcutivityLimit
        let limit = newProdcutivityLimit.prefix(2)
        let lim = Int(limit)
        self.productivityLimitInt = lim!
    }
    
    func saveChildLimits(limitRef:DatabaseReference?){
        var userID:String? = ""
        if (limitRef == nil){
            self.ref = Database.database().reference()
            userID = Auth.auth().currentUser?.uid
            guard let key = ref?.child("CategoryLimits").childByAutoId().key else { return }
            let limits = ["uid": userID,
                          "GameLimits": self.gameLimit,
                          "EducationLimits": self.educationLimit,
                          "ProductivityLimits": self.productivityLimit,
                ] as [String : Any]
            let limitUpdate = ["/CategoryLimits/\(key)": limits]
            self.ref?.updateChildValues(limitUpdate)
        }
        else{
            self.ref = limitRef
            userID = "IVDw4blq8qgyJ6fKQxDoVb9h6YZ2"
            guard let key = ref?.child("CategoryLimits").childByAutoId().key else { return }
            self.ref?.updateChildValues(["uid": userID,
                                         "GameLimits": self.gameLimit,
                                         "EducationLimits": self.educationLimit,
                                         "ProductivityLimits": self.productivityLimit])
        }
    }
}
