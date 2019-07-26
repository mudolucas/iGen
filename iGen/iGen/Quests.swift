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

enum Status{
    case active
    case completed
    case expired
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .active: return "active"
        case .completed: return "completed"
        case .expired: return "expired"
        }
    }
}

class Quests{
    
    var title:String
    var reward:Int
    var status:Status
    var frequency:Int
    var deadline:String
    
    public init(title: String, reward:Int,frequency:Int,deadline:String,status:Status) {
        self.title = title
        self.status = status
        self.reward = reward
        self.frequency = frequency
        self.deadline = deadline
    }
    
    func saveQuestIntoDatabase() {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        guard let key = ref?.child("quests").childByAutoId().key else { return }
        let quest = ["uid": userID,
                    "title": self.title,
                    "reward": self.reward,
                    "frequency": self.frequency,
                    "deadline": self.deadline,
                    "status":self.status.description
            ] as [String : Any]
        let childUpdates = ["/quests/\(key)": quest,
                           "/users/\(userID)/\(key)/": quest]
        ref?.updateChildValues(childUpdates)
    }
    
    class func loadAllQuestsForUser() -> [Quests] {
        ref = Database.database().reference().child("quests")
        let userID = Auth.auth().currentUser?.uid
        var questsArray = [Quests]()
        ref?.observe(.childAdded, with: { (snapshot) in
            
            //Convert the info of the data into a string variable
            if let getData = snapshot.value as? [String:Any] {
                let title:String = getData["title"] as! String
                let reward:Int = getData["reward"] as! Int
                let deadline:String = getData["deadline"] as! String
                let frequency:Int = getData["frequency"] as! Int
                questsArray.append(Quests(title: title, reward: reward, frequency: frequency, deadline: deadline, status: Status.active))
            }
            })
        return questsArray
    }
}
