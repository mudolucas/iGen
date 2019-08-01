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
            let productivityLimit: String = savedLimits["ProductivityLimits"] as? String,
            let gameLimitInt: Int = savedLimits["GameTimeInInt"] as? Int,
            let educationLimitInt: Int = savedLimits["EducationTimeInInt"] as? Int,
            let productivityLimitInt: Int = savedLimits["ProductivityTimeInInt"] as? Int
        else{
                return nil
        }
        self.limitRef = snapshot.ref
        self.gameLimit = gameLimit
        self.educationLimit = educationLimit
        self.productivityLimit = productivityLimit
        self.gameLimitInt = gameLimitInt
        self.educationLimitInt = educationLimitInt
        self.productivityLimitInt = productivityLimitInt
    }
    
    func changeGameLimit(newGameLimit: String){
        self.gameLimit = newGameLimit
        let totalTime = calculateTotalLim(limit: newGameLimit)
        self.gameLimitInt = totalTime
    }
    
    func changeEducationLimit(newEducationLimit: String){
        self.educationLimit = newEducationLimit
        let totalTime = calculateTotalLim(limit: newEducationLimit)
        self.educationLimitInt = totalTime
    }
    
    func changeProductivityLimit(newProdcutivityLimit: String){
        self.productivityLimit = newProdcutivityLimit
        let totalTime = calculateTotalLim(limit: newProdcutivityLimit)
        self.productivityLimitInt = totalTime
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
                          "GameTimeInInt": self.gameLimitInt,
                          "EducationTimeInInt": self.educationLimitInt,
                          "ProductivityTimeInInt": self.productivityLimitInt
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
                                         "ProductivityLimits": self.productivityLimit,
                                         "GameTimeInInt": self.gameLimitInt,
                                         "EducationTimeInInt": self.educationLimitInt,
                                         "ProductivityTimeInInt": self.productivityLimitInt])
        }
    }
   
    private func calculateTotalLim(limit: String) -> Int{
        let lim = limit.prefix(2)
        let stringHour = Int(lim)
        let hour = stringHour! * 60
        let it = limit.suffix(2)
        let stringMin = Int(it)
        let min = stringMin!
        let total = hour + min
        return total
    }
    
}
