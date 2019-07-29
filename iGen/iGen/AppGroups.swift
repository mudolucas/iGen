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
        datePicker?.addTarget(self, action: #selector(AppGroups.dateChanged(datePicker:)), for: .valueChanged)
        gamesTimer.inputView = datePicker
        educationdatePicker = UIDatePicker()
        educationdatePicker?.datePickerMode = .countDownTimer
        educationdatePicker?.addTarget(self, action: #selector(AppGroups.edudateChanged(datePicker:)), for: .valueChanged)
        educationTimer.inputView = educationdatePicker
        productivitydatePicker = UIDatePicker()
        productivitydatePicker?.datePickerMode = .countDownTimer
        productivitydatePicker?.addTarget(self, action: #selector(AppGroups.prodateChanged(datePicker:)), for: .valueChanged)
        productivityTimer.inputView = productivitydatePicker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AppGroups.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        gamesTimer.text = dateformatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    @objc func edudateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        educationTimer.text = dateformatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    @objc func prodateChanged(datePicker: UIDatePicker){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        productivityTimer.text = dateformatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        
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
