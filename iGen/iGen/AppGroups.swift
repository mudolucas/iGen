//
//  AppGroups.swift
//  iGen
//
//  Created by Daniel Molina on 7/26/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit

class AppGroups: UIViewController {
    @IBOutlet weak var gamesTimer: UITextField!
    
    @IBOutlet weak var educationTimer: UITextField!
    
    @IBOutlet weak var productivityTimer: UITextField!
    
    var lastClickedField : UITextField?
    
    private var datePicker: UIDatePicker?
    private var educationdatePicker: UIDatePicker?
    private var productivitydatePicker: UIDatePicker?
    var userLimits = AppTimeSet(gameLimit: "Unlimited", educationLimit: "Unlimited", productivityLimit: "Unlimited")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let gamesToolBar = UIToolbar().ToolbarPiker(unlimitedSelect: #selector(AppGroups.setGameUnlimited), blockSelect: #selector(AppGroups.setGameBlocked))
        let educationToolBar = UIToolbar().ToolbarPiker(unlimitedSelect: #selector(AppGroups.setEducationUnlimited), blockSelect: #selector(AppGroups.setEducationBlocked))
         let productivityToolBar = UIToolbar().ToolbarPiker(unlimitedSelect: #selector(AppGroups.setProductivityUnlimited), blockSelect: #selector(AppGroups.setProductivityBlocked))
        gamesTimer.backgroundColor = newColors.colorLightBlue()
        educationTimer.backgroundColor = newColors.colorLightBlue()
        productivityTimer.backgroundColor = newColors.colorLightBlue()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .countDownTimer
        gamesTimer.inputAccessoryView = gamesToolBar
        datePicker?.addTarget(self, action: #selector(AppGroups.dateChanged(datePicker:)), for: .valueChanged)
        gamesTimer.inputView = datePicker
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AppGroups.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        gamesTimer.text = dateformatter.string(from: datePicker.date)
        userLimits.changeGameLimit(newGameLimit: dateformatter.string(from: datePicker.date))
        view.endEditing(true)
    }
    @objc func edudateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        educationTimer.text = dateformatter.string(from: datePicker.date)
        userLimits.changeEducationLimit(newEducationLimit: dateformatter.string(from: datePicker.date))
        view.endEditing(true)
    }
    @objc func prodateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        productivityTimer.text = dateformatter.string(from: datePicker.date)
        userLimits.changeProductivityLimit(newProdcutivityLimit: dateformatter.string(from: datePicker.date))
        view.endEditing(true)
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        
        view.endEditing(true)
        
    }
    @objc func setGameUnlimited(){
        userLimits.changeGameLimit(newGameLimit: "Unlimited")
        gamesTimer.text = "Unlimited"
    }
    @objc func setGameBlocked(){
        userLimits.changeGameLimit(newGameLimit: "Blocked")
        gamesTimer.text = "Blocked"
    }
    @objc func setEducationUnlimited(){
        userLimits.changeGameLimit(newGameLimit: "Unlimited")
        educationTimer.text = "Unlimited"
    }
    @objc func setEducationBlocked(){
        userLimits.changeGameLimit(newGameLimit: "Blocked")
        educationTimer.text = "Blocked"
    }
    @objc func setProductivityUnlimited(){
        userLimits.changeGameLimit(newGameLimit: "Unlimited")
        productivityTimer.text = "Unlimited"
    }
    @objc func setProductivityBlocked(){
        userLimits.changeGameLimit(newGameLimit: "Blocked")
        productivityTimer.text = "Blocked"
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
