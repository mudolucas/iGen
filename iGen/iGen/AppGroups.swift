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
    
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        lastClickedField = textField
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .countDownTimer
        datePicker?.addTarget(self, action: #selector(AppGroups.dateSelected(datePicker:)), for: .valueChanged)
        lastClickedField?.inputView = datePicker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AppGroups.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        lastClickedField?.text = dateformatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        lastClickedField = nil
        view.endEditing(true)
        
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
