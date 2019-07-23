import UIKit

// HELPERS
struct tableData{
    var opened = Bool()
    var title = String()
    var questsData = [Quests]()
}

class tableViewOutlets: UITableViewCell{
    @IBOutlet weak var questTitleCell: UILabel!
    @IBOutlet weak var rewardCell: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
}

class QuestsViewController: UITableViewController{
    private var tableViewData = [tableData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [tableData(opened: false, title: "Active", questsData: [Quests(title: "Make your bed", reward: "45")]),tableData(opened: false, title: "Completed", questsData: [Quests(title: "Do your math work", reward: "50")])]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return tableViewData[section].questsData.count+1
        }else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TITLE CELLS
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! tableViewOutlets
            cell.questTitleCell.text = tableViewData[indexPath.section].title
            cell.backgroundColor = UIColor(red: 93/255, green: 188/255, blue: 210/255, alpha: 1.0)
            cell.rewardCell?.text = nil
            cell.iconImage.image = nil
            return cell
        }else{
            //CONTENT CELLS
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! tableViewOutlets
            cell.questTitleCell.text = tableViewData[indexPath.section].questsData[indexPath.row - 1].title
            let rwd = String(tableViewData[indexPath.section].questsData[indexPath.row - 1].reward)
            cell.rewardCell?.text = rwd
            cell.iconImage.image = UIImage(named: "Clock_icon")
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if tableViewData[indexPath.section].opened == true{
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else{
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
    
    
    
    
    
}
