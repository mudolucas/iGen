//
//  MyCustomTableViewCell.swift
//  iGen
//
//  Created by Lia Johansen on 7/25/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit

class MyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var kidModeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // SWITCH: PARENT TO KID AND KID TO PARENT
    @IBAction func kidModeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("button is pressed to on AKA childMode is ON!!!")
        } else {
            print("button is pressed to OFF --> go into the popup")
            // sender.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
            
            
            
        }
    }
}


