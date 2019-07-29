//
//  editQuestViewController.swift
//  iGen
//
//  Created by Lucas Mudo de Araujo on 7/29/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit

class editQuestViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var rewardTextField: UITextField!
    @IBOutlet private var deadlineTextField: UITextField!
    @IBOutlet private var selectionList: SelectionList!
    private var datePicker: UIDatePicker?
    var quest:Quests?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        setUpDatePicker()
        rewardTextField.delegate = self
    }
    
    
    private func viewDesign(){
        //FREQUENCY LIST
        selectionList.items = ["One time only","Once a week","Weekly"]
        selectionList.allowsMultipleSelection = false
        selectionList.selectionImage = UIImage(named: "v")
        selectionList.deselectionImage = UIImage(named: "o")
        selectionList.isSelectionMarkTrailing = false // to put checkmark on left side
        selectionList.rowHeight = 40.0
        selectionList.selectedIndex = quest?.frequency
        
        selectionList.tableView.separatorColor = UIColor.clear
        selectionList.setupCell = { (cell: UITableViewCell, _: Int) in
            cell.textLabel?.textColor = DesignHelper.colorDarkestBlue()
            cell.textLabel?.font = UIFont(name:"Avenir", size:15)
        }
        
        //TEXT FIELDS
        titleTextField.text = quest?.title
        titleTextField.textColor = DesignHelper.colorDarkestBlue()
        rewardTextField.textColor = DesignHelper.colorDarkestBlue()
        rewardTextField.text = "\(quest?.reward)"
        deadlineTextField.text = quest?.deadline
    }
    
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
}
