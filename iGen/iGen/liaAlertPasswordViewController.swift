//
//  liaAlertPasswordViewController.swift
//  iGen
//
//  Created by Lia Johansen on 7/26/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit

class liaAlertPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createAlert(title: "testing", message: "does this work")
        // Do any additional setup after loading the view.
    }
    
    
    
    func createAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        
        // CREATING THOSE CANCEL OR OKAY BUTTONS
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "SUBMIT", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            // COMPARE THE PASSCODE
        }))
        
        
        self.present(alert, animated: true, completion: nil)
        
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
