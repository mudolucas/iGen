//
//  Quests.swift
//  iGen
//
//  Created by Lucas Mudo de Araujo on 7/19/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

var ref: DatabaseReference?

enum Frequency{
    case one_time_only 
    case weekly
    case everyday
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .one_time_only: return "one_time_only"
        case .weekly: return "weekly"
        case .everyday: return "everyday"
        }
    }
}
enum Status{
    case active
    case completed
    case expired
}

class Quests{
    
    var title:String
    var reward:Int
    var status:Status
    var frequency:Frequency
    var deadline:String
    
    public init(title: String, reward:String,frequency:Frequency,deadline:String) {
        self.title = title
        self.status = .active
        let rwd = Int(reward) ?? 0
        self.reward = rwd
        self.frequency = frequency
        self.deadline = deadline
    }
    
    func addQuest() {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        guard let key = ref?.child("quests").childByAutoId().key else { return }
        let quest = ["uid": userID,
                    "title": self.title,
                    "reward": self.reward,
                    "freqeuncy": self.frequency.description,
                    "deadline": self.deadline
            ] as [String : Any]
        let childUpdates = ["/quests/\(key)": quest,
                           "/users/\(userID)/\(key)/": quest]
        ref?.updateChildValues(childUpdates)
    }
    
    class func viewDatabaseQuests() {
        ref = Database.database().reference().child("quests")
        let userID = Auth.auth().currentUser?.uid
       // let something = ref?.child("quests").queryOrdered(byChild: "uid").queryEqual(toValue: userID)
      //  print(something)
        ref?.observe(.childAdded, with: { (snapshot) in
            
            //Convert the info of the data into a string variable
            if let getData = snapshot.value as? [String:Any] {
                
                print(getData)
                
                let titles = getData["title"] as? String
                
                print("\(titles)")
                
            }
            
        })
    }
}
