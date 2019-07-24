//
//  addQuestViewController.swift
//  iGen
//
//  Created by Lucas Mudo de Araujo on 7/22/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit
//import SelectionList

class addQuestViewController: UIViewController {
    var questTitle:String = ""
    var questReward:String = ""
    var selectedFrequency:Int = 0
    
    @IBOutlet weak var rewardTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectionList: SelectionList!
    @IBOutlet weak var deadlineTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        setUpDatePicker()
    }
    
   
    
    // GATHER THE INFORMATION INPUTED BY THE USER TO TRANSFER TO THE NEXT SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            questTitle = titleTextField.text!
            questReward = rewardTextField.text!
            //selectedFrequency = selectionList.selectedIndex!
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
    
    private func setUpDatePicker(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        deadlineTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(addQuestViewController.dateChanged(datePicker:)), for: .valueChanged)
        let tapGestureDatePicker = UITapGestureRecognizer(target: self, action: #selector(addQuestViewController.viewTapper(gestureRecognizer:)))
        view.addGestureRecognizer(tapGestureDatePicker)
    }
    
    
    private func viewDesign(){
        //FREQUENCY LIST
        selectionList.items = ["One time only","Once a week","Weekly"]
        selectionList.allowsMultipleSelection = false
        selectionList.selectionImage = UIImage(named: "v")
        selectionList.deselectionImage = UIImage(named: "o")
        selectionList.isSelectionMarkTrailing = false // to put checkmark on left side
        selectionList.rowHeight = 40.0
        
        selectionList.tableView.separatorColor = UIColor.clear
        selectionList.setupCell = { (cell: UITableViewCell, _: Int) in
            cell.textLabel?.textColor = DesignHelper.colorDarkAssBlue()
            cell.textLabel?.font = UIFont(name:"Avenir", size:15)
        }
    
        //TEXT FIELDS
        titleTextField.placeholder = "Title"
        titleTextField.textColor = DesignHelper.colorDarkAssBlue()
        rewardTextField.textColor = DesignHelper.colorDarkAssBlue()
        rewardTextField.keyboardType = .numberPad
        rewardTextField.placeholder = "Reward"
        deadlineTextField.placeholder = "Pick a date"
    }
}
