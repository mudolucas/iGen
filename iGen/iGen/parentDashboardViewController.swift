//
//  parentDashboardViewController.swift
//  iGen
//
//  Created by Lucas Mudo de Araujo on 7/31/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import UIKit

class parentDashboardViewController: UIViewController {

    @IBOutlet var dayButton: UIButton!
    @IBOutlet var weekButton: UIButton!
    @IBOutlet var monthButton: UIButton!
    @IBOutlet var segmented: UISegmentedControl!
    @IBOutlet var graphImage: UIImageView!
    @IBOutlet var graphTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayButtonSelected()
        graphImage.image = UIImage(named: "dayAppUsage")
        graphTitleLabel.text = "Charlie's App Usage"
        
    }
    @IBAction func segmentedChanged(_ sender: Any) {
        if (segmented.selectedSegmentIndex == 0){
            dayButtonSelected()
            graphImage.image = UIImage(named: "dayAppUsage")
            graphTitleLabel.text = "Charlie's App Usage"
        }else{
            dayButtonSelected()
            graphImage.image = UIImage(named: "dayMoneySpent")
            graphTitleLabel.text = "Charlie's Spendatures"
        }
    }
    
    @IBAction func touchedDayButton(_ sender: Any) {
        dayButtonSelected()
        if (segmented.selectedSegmentIndex == 0){
            graphImage.image = UIImage(named: "dayAppUsage")
        }else{
            graphImage.image = UIImage(named: "dayMoneySpent")
        }
    }
    
    @IBAction func touchedWeekButton(_ sender: Any) {
        weekButtonSelected()
        if (segmented.selectedSegmentIndex == 0){
            graphImage.image = UIImage(named: "weekAppUsage")
        }else{
            graphImage.image = UIImage(named: "weekMoneySpent")
        }
    }
    
    @IBAction func touchedMonthButton(_ sender: Any) {
        monthButtonSelected()
        if (segmented.selectedSegmentIndex == 0){
            graphImage.image = UIImage(named: "monthAppUsage")
        }else{
            graphImage.image = UIImage(named: "monthMoneySpent")
        }
    }
    
    private func weekButtonSelected(){
        weekButton.setImage(UIImage(named: "week_filled"), for: .normal)
        dayButton.setImage(UIImage(named: "day_blank"), for: .normal)
        monthButton.setImage(UIImage(named: "month_blank"), for: .normal)
    }
    
    private func dayButtonSelected(){
        weekButton.setImage(UIImage(named: "week_blank"), for: .normal)
        dayButton.setImage(UIImage(named: "day_filled"), for: .normal)
        monthButton.setImage(UIImage(named: "month_blank"), for: .normal)
    }
    private func monthButtonSelected(){
        weekButton.setImage(UIImage(named: "week_blank"), for: .normal)
        dayButton.setImage(UIImage(named: "day_blank"), for: .normal)
        monthButton.setImage(UIImage(named: "month_filled"), for: .normal)
    }
}
