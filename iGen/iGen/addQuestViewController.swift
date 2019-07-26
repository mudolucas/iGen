//
//  addQuestViewController.swift
//  iGen
//
//  Created by Lucas Mudo de Araujo on 7/22/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit
//import SelectionList

class addQuestViewController: UIViewController, UITextFieldDelegate {
    var newQuestTitle:String = ""
    var newQuestReward:String = ""
    var newQuestFrequency:Int = -1
    var newQuestDeadline:String = ""
    private var datePicker: UIDatePicker?
    
    @IBOutlet weak var rewardTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectionList: SelectionList!
    @IBOutlet weak var deadlineTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        setUpDatePicker()
        rewardTextField.delegate = self
    }
    
    @IBAction func send(_ sender: Any) {
        if (rewardTextField!.text != "" && titleTextField!.text != "" && selectionList.selectedIndex != -1 && deadlineTextField.text != ""){
            self.performSegue(withIdentifier: "doneCreatingQuestSegue", sender: nil)
        }else{
            let alert = UIAlertController(title:"Please, fill out all the fields", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    // GATHER THE INFORMATION INPUTED BY THE USER TO TRANSFER TO THE NEXT SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        newQuestTitle = titleTextField.text!
        newQuestReward = rewardTextField.text!
        newQuestFrequency = selectionList.selectedIndex! ?? -1
        newQuestDeadline = deadlineTextField.text!
    }
    
    //DISMISS THE DATE PICKER EVEN IF THE USER DIDN'T CHANGE ANYTHING
    @objc func viewTapper(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    //CHANGE THE TEXT IN THE TEXT FIELD ACCORDINLY WITH THE USER INOUT AND DISSMISS THE DATE PICKER
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        deadlineTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    // SET UP THE DATE  PICKER INTO A TEXT FIELD
    private func setUpDatePicker(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.minimumDate = Date()
        deadlineTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(addQuestViewController.dateChanged(datePicker:)), for: .valueChanged)
        //let tapGestureDatePicker = UITapGestureRecognizer(target: self, action: #selector(addQuestViewController.viewTapper(gestureRecognizer:)))
        //view.addGestureRecognizer(tapGestureDatePicker)
    }
    
    
    //SETTING THE REWARD TEXT FIELD INPUT TO BE NUMBERS ONLY
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.isEmpty || string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil
    }
    
    private func viewDesign(){
        //FREQUENCY LIST
        selectionList.items = ["One time only","Once a week","Weekly"]
        selectionList.allowsMultipleSelection = false
        selectionList.selectionImage = UIImage(named: "v")
        selectionList.deselectionImage = UIImage(named: "o")
        selectionList.isSelectionMarkTrailing = false // to put checkmark on left side
        selectionList.rowHeight = 40.0
        selectionList.selectedIndex = 0
        
        selectionList.tableView.separatorColor = UIColor.clear
        selectionList.setupCell = { (cell: UITableViewCell, _: Int) in
            cell.textLabel?.textColor = DesignHelper.colorDarkestBlue()
            cell.textLabel?.font = UIFont(name:"Avenir", size:15)
        }
    
        //TEXT FIELDS
        titleTextField.placeholder = "Title"
        titleTextField.textColor = DesignHelper.colorDarkestBlue()
        rewardTextField.textColor = DesignHelper.colorDarkestBlue()
        deadlineTextField.placeholder = "Pick a date"
    }
}
