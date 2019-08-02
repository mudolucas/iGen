//
//  kidsTableViewController.swift
//  iGen
//
//  Created by Lucas Mudo de Araujo on 7/30/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


class kidQuestTableOutlets: UITableViewCell{
    @IBOutlet var titleTextField: UILabel!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var rewardTextField: UILabel!
    
}

class kidsTableViewController: UITableViewController{
    private var tableData:[Quests] = []
    private var parentPin = String()
    private var userReference: DatabaseReference?
    private var wallet = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadKidQuests()
        getPinCode()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("-----   \(tableData.count)   -----")
        return tableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kidcell", for: indexPath) as! kidQuestTableOutlets
        let quest = self.tableData[indexPath.row]
        cell.titleTextField.text = quest.title
        cell.rewardTextField?.text = String(quest.reward)
        cell.iconImage.image = DesignHelper.clockImageParent()
        cell.detailTextLabel?.text = "Days Left"
        return cell
    }
    
    // WHEN A ROW IS SELECTED
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "Almost there!",
            message: "Ask Tommi's boss for the secret PIN",
            preferredStyle: .alert)
        
        // Add a text field to the alert for the new item's title
        alert.addTextField { (textField: UITextField) in
            textField.keyboardType = .numberPad
            textField.autocorrectionType = .default
            textField.placeholder = "Pin"
            textField.text = "1234"
            textField.isSecureTextEntry = true
            textField.textAlignment = .center
            textField.clearButtonMode = .whileEditing
        }
        
        // Add a "cancel" button to the alert. This one doesn't need a handler
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add a "OK" button to the alert. The handler calls addNewToDoItem()
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (_) in
            if let inputedPin = alert.textFields?[0].text as? String {
                if inputedPin == self.parentPin{
                    self.tableData[indexPath.row].quest_ref?.updateChildValues(["status": Status.completed.description])
                    let updatedWallet:Int = self.wallet + self.tableData[indexPath.row].reward
                    self.imageReward(reward: self.tableData[indexPath.row].reward)
                    self.userReference?.updateChildValues(["wallet":updatedWallet])
                    self.tableView.reloadData()
                }
            }
        }))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func imageReward(reward:Int){
        let showAlert = UIAlertController(title: "Congrats!!", message: "You've earned \(reward) coins", preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 20, y: 60, width: 250, height: 260))
        imageView.image = UIImage(named: "rewardTommi")
        showAlert.view.addSubview(imageView)
        let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 360)
        let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 290)
        showAlert.view.addConstraint(height)
        showAlert.view.addConstraint(width)
        showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // your actions here...
        }))
        self.present(showAlert, animated: true, completion: nil)
    }
    
    private func loadKidQuests(){
        self.tableData.removeAll()
        let ref = Database.database().reference().child("quests")
        let userID = Auth.auth().currentUser?.uid
        let query = ref.queryOrdered(byChild: "uid").queryEqual(toValue: userID!)
        query.observe(.value, with: { (snapshot) in
            var loadedItems:[Quests] = []
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot{
                    if let data = snapshot.value as? [String:Any]{
                        let status = data["status"] as? String
                        if status == "active"{
                            if let newQuest = Quests(snapshot: snapshot) as? Quests{
                                loadedItems.append(newQuest)
                            }
                        }
                    }
                }
            }
            self.tableData = loadedItems
            self.tableView.reloadData()
        })
    }
    
    private func getPinCode(){
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var loadedPin:String=""
            if let value = snapshot.value as? [String:Any]{
                if let pin = value["pin"] as? String{
                    loadedPin = pin
                }
                if let wallet = value["wallet"] as? Int{
                    self.wallet = wallet
                }
            }
            self.userReference = snapshot.ref
            self.parentPin = loadedPin
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
