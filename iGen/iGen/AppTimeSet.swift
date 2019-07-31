//
//  AppTimeSet.swift
//  iGen
//
//  Created by Daniel Molina on 7/29/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import Foundation

class AppTimeSet{
    var gameLimit: String
    var educationLimit: String
    var productivityLimit: String
    
    init(gameLimit: String, educationLimit: String, productivityLimit: String) {
        self.gameLimit = gameLimit
        self.educationLimit = educationLimit
        self.productivityLimit = productivityLimit
    }
    
    func changeGameLimit(newGameLimit: String){
        self.gameLimit = newGameLimit
    }
    
    func changeEducationLimit(newEducationLimit: String){
        self.educationLimit = newEducationLimit
    }
    
    func changeProductivityLimit(newProdcutivityLimit: String){
        self.educationLimit = newProdcutivityLimit
    }
}
