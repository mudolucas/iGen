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
    
    @IBOutlet weak var reward: UITextField!
    @IBOutlet weak var questTitle: UITextField!
    @IBOutlet weak var selectionList: SelectionList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectionList.items = ["One Time Only","Once a week","Weekly"]
        selectionList.allowsMultipleSelection = false
        selectionList.setupCell = { (cell: UITableViewCell, _: Int) in
            cell.textLabel?.textColor = .black
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            
        }
    }
    
    
    /*@objc func selectionChanged() {
     print(selectionList.selectedIndexes)
     }*/
}
