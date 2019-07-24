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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            questTitle = titleTextField.text!
            questReward = rewardTextField.text!
            //selectedFrequency = selectionList.selectedIndex!
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
    }
}
