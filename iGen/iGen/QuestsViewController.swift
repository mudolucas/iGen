import UIKit

// HELPERS
private struct tableData{
    var opened = Bool()
    var title = String()
    var questsData = [Quests]()
}

class tableViewOutlets: UITableViewCell{
    @IBOutlet weak var questTitleCell: UILabel!
    @IBOutlet weak var rewardCell: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var sectionTitle: UILabel!
    
}

class QuestsViewController: UITableViewController{
    private var tableViewData = [tableData]() //LOCAL DATA ARRAY
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [tableData(opened: false, title: "Active", questsData: []),tableData(opened: false, title: "Completed", questsData: [])]
    }
    
    // DEFINE THE NUMBER OF SECTIONS IN THE TABLE
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    //RETURN HOW MANY ROWS PER SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return tableViewData[section].questsData.count+1
        }else{
            return 1
        }
    }
    
    //filling the table accordindly
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TITLE CELLS
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as! tableViewOutlets
            cell.sectionTitle.text = tableViewData[indexPath.section].title
            cell.backgroundColor = DesignHelper.colorDarkBlue()
            return cell
        }else{
            //CONTENT CELLS
            let dataIndex = indexPath.row - 1
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! tableViewOutlets
            let quest:Quests = tableViewData[indexPath.section].questsData[dataIndex]
            cell.questTitleCell.text = quest.title
            cell.rewardCell?.text = String(quest.reward)
            cell.iconImage.image = UIImage(named: "Clock_icon")
            return cell
        }
    }
    
    // WHEN A ROW IS SELECTED, RUN THIS FUNCTION
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //EXAPND OR NOT CERTAIN SECTION
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
    
    //DELETE A ROW
    //MARK: IMPLEMENT DELETE!!
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if indexPath.row != 0{
            tableViewData[indexPath.section].questsData.remove(at: indexPath.row)
        }
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue){}
    
    @IBAction func done(_ unwindSegue: UIStoryboardSegue) {
        let newQuest = unwindSegue.source as! addQuestViewController
        var f:Frequency
        switch newQuest.newQuestFrequency {
        case 0:
            f = .one_time_only
        case 1:
            f = .weekly
        case 2:
            f = .everyday
        default:
            f = .one_time_only
        }
        tableViewData[0].questsData.append(Quests(title: newQuest.newQuestTitle, reward: newQuest.newQuestReward, frequency: f,deadline: newQuest.newQuestDeadline))
        tableView.reloadData()
    }
}
