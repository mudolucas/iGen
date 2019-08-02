//
//  AppGroups.swift
//  iGen
//
//  Created by Daniel Molina on 7/26/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


class AppGroups: UIViewController {
    //IBOutlets for Text Fields
    @IBOutlet weak var gamesTimer: UITextField!
    
    @IBOutlet weak var educationTimer: UITextField!
    
    @IBOutlet weak var productivityTimer: UITextField!
    
    @IBOutlet weak var gamesLabel: UILabel!
    
    @IBOutlet weak var educationLabel: UILabel!
    
    @IBOutlet weak var productivityLabel: UILabel!
    
    private var limitation_ref: DatabaseReference?
    //Date Pickers for each text field
    private var datePicker: UIDatePicker?
    private var educationdatePicker: UIDatePicker?
    private var productivitydatePicker: UIDatePicker?
    //Initiate an App Time Set class
    var userLimits = AppTimeSet(gameLimit: "Unlimited", educationLimit: "Unlimited", productivityLimit: "Unlimited")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set UI Tool Bar
        let gamesToolBar = UIToolbar().ToolbarPiker(unlimitedSelect: #selector(AppGroups.setGameUnlimited), blockSelect: #selector(AppGroups.setGameBlocked))
        let educationToolBar = UIToolbar().ToolbarPiker(unlimitedSelect: #selector(AppGroups.setEducationUnlimited), blockSelect: #selector(AppGroups.setEducationBlocked))
        let productivityToolBar = UIToolbar().ToolbarPiker(unlimitedSelect: #selector(AppGroups.setProductivityUnlimited), blockSelect: #selector(AppGroups.setProductivityBlocked))
        gamesLabel.font = UIFont.boldSystemFont(ofSize: gamesLabel.font.pointSize)
        educationLabel.font = UIFont.boldSystemFont(ofSize: educationLabel.font.pointSize)
         productivityLabel.font = UIFont.boldSystemFont(ofSize: productivityLabel.font.pointSize)
        //Background Color for Timers
        gamesTimer.backgroundColor = newColors.colorLightBlue()
        educationTimer.backgroundColor = newColors.colorLightBlue()
        productivityTimer.backgroundColor = newColors.colorLightBlue()
        //Initialize Date Picker and Set it up as a Count Down Timer
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .countDownTimer
        gamesTimer.inputAccessoryView = gamesToolBar
        //Set Date when DatePicker is clicked
        datePicker?.addTarget(self, action: #selector(AppGroups.dateChanged(datePicker:)), for: .valueChanged)
        gamesTimer.inputView = datePicker
        //Repeat for education and productivity
        educationdatePicker = UIDatePicker()
        educationdatePicker?.datePickerMode = .countDownTimer
        educationdatePicker?.addTarget(self, action: #selector(AppGroups.edudateChanged(datePicker:)), for: .valueChanged)
        educationTimer.inputAccessoryView = educationToolBar
        educationTimer.inputView = educationdatePicker
        productivitydatePicker = UIDatePicker()
        productivitydatePicker?.datePickerMode = .countDownTimer
        productivitydatePicker?.addTarget(self, action: #selector(AppGroups.prodateChanged(datePicker:)), for: .valueChanged)
        productivityTimer.inputView = productivitydatePicker
        productivityTimer.inputAccessoryView = productivityToolBar
        //Tap Gesture for the screen
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AppGroups.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadLimits()
    }
    //set time for the text fields and save to data base
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        gamesTimer.text = dateformatter.string(from: datePicker.date)
        userLimits.changeGameLimit(newGameLimit: dateformatter.string(from: datePicker.date))
        userLimits.saveChildLimits(limitRef: self.limitation_ref)
        view.endEditing(true)

    }
    @objc func edudateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        educationTimer.text = dateformatter.string(from: datePicker.date)
        userLimits.changeEducationLimit(newEducationLimit: dateformatter.string(from: datePicker.date))
        
        userLimits.saveChildLimits(limitRef: self.limitation_ref)
        view.endEditing(true)
    }
    @objc func prodateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        productivityTimer.text = dateformatter.string(from: datePicker.date)
        
        userLimits.changeProductivityLimit(newProdcutivityLimit: dateformatter.string(from: datePicker.date))
        
        userLimits.saveChildLimits(limitRef: self.limitation_ref)
        
        view.endEditing(true)
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        
        view.endEditing(true)
        
    }
    //Set an unlimited setting
    @objc func setGameUnlimited(){
        userLimits.changeGameLimit(newGameLimit: "Unlimited")
        gamesTimer.text = "Unlimited"
        userLimits.saveChildLimits(limitRef: self.limitation_ref)

        view.endEditing(true)
    }
    //set a blocked setting
    @objc func setGameBlocked(){
        userLimits.changeGameLimit(newGameLimit: "Blocked")
        gamesTimer.text = "Blocked"
        userLimits.saveChildLimits(limitRef: self.limitation_ref)
        view.endEditing(true)
    }
    @objc func setEducationUnlimited(){
        userLimits.changeEducationLimit(newEducationLimit: "Unlimited")
        educationTimer.text = "Unlimited"
        userLimits.saveChildLimits(limitRef: self.limitation_ref)
        view.endEditing(true)
    }
    @objc func setEducationBlocked(){
        userLimits.changeEducationLimit(newEducationLimit: "Blocked")
        educationTimer.text = "Blocked"
        userLimits.saveChildLimits(limitRef: self.limitation_ref)
        view.endEditing(true)
    }
    @objc func setProductivityUnlimited(){
        userLimits.changeProductivityLimit(newProdcutivityLimit: "Unlimited")
        productivityTimer.text = "Unlimited"
        userLimits.saveChildLimits(limitRef: self.limitation_ref)
        view.endEditing(true)
    }
    @objc func setProductivityBlocked(){
        userLimits.changeProductivityLimit(newProdcutivityLimit: "Blocked")
        productivityTimer.text = "Blocked"
        userLimits.saveChildLimits(limitRef: self.limitation_ref)
        view.endEditing(true)
    }
    
    
    private func loadLimits(){
        let ref = Database.database().reference().child("CategoryLimits")
        let userID = Auth.auth().currentUser?.uid
        let query = ref.queryOrdered(byChild: "uid").queryEqual(toValue: userID)
        query.observe(.value, with: { (snapshot) in
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot{
                    if let newLoadTimes = AppTimeSet(snapshot: snapshot) as? AppTimeSet{
                        self.gamesTimer.text = newLoadTimes.gameLimit
                        self.educationTimer.text = newLoadTimes.educationLimit
                        self.productivityTimer.text = newLoadTimes.productivityLimit
                        self.limitation_ref = snapshot.ref
                        self.userLimits = newLoadTimes
                    }
                }
            }
        })
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension UIToolbar {
    
    func ToolbarPiker(unlimitedSelect : Selector, blockSelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let unlimitedButton = UIBarButtonItem(title: "Set Unlimited Time", style: UIBarButtonItem.Style.plain, target: self, action: unlimitedSelect)
        let blockButton = UIBarButtonItem(title: "Block Usage", style: UIBarButtonItem.Style.plain, target: self, action: blockSelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([blockButton, spaceButton, spaceButton, unlimitedButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}

