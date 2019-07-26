//
//  liaSettingViewController.swift
//  iGen
//
//  Created by Lia Johansen on 7/25/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit


class liaSettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MyCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCustomCell")
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellToAlert", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //if let destination = segue.destination as? UIViewController {
            
           // destination.product = productArray[(tblAppleProducts.indexPathForSelectedRow?.row)!]
            
            //tblAppleProducts.deselectRow(at: tblAppleProducts.indexPathForSelectedRow!, animated: true)
            
        }
    }
    



extension UIViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell") as! MyCustomTableViewCell
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
