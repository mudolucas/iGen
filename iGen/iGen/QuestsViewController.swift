import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

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
    //@IBOutlet weak var description: UILabel!
}

class QuestsViewController: UITableViewController{
    private var tableViewData = [tableData]() //LOCAL DATA ARRAY
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewData = [tableData(opened: true, title: "Active", questsData:[]),tableData(opened: true, title: "Completed", questsData: [])]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadQuests()
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
            cell.iconImage.image = DesignHelper.clockImageParent()
            cell.detailTextLabel?.text = "Deadline:  \(quest.deadline)"
            return cell
        }
    }
    
    // WHEN A ROW IS SELECTED, RUN THIS FUNCTION
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
    
    //DELETE A QUEST
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if indexPath.row != 0{
            if editingStyle == .delete {
                let quest = tableViewData[0].questsData[indexPath.row-1]
                quest.quest_ref?.removeValue()
                tableViewData[0].questsData.remove(at: indexPath.row-1)
                tableView.reloadData()
                print("COUNT \(tableViewData[0].questsData.count)")
            }
        }
    }
    
    //SEGUE FUNCTIONS
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue){}
    @IBAction func done(_ unwindSegue: UIStoryboardSegue) {}
    @IBAction func cancelEditing(_ unwindSegue: UIStoryboardSegue) {}
    
    @IBAction func doneEditing(_ unwindSegue: UIStoryboardSegue) {
        let editedQuest = unwindSegue.source as! editQuestViewController
        self.tableViewData[0].questsData[editedQuest.index!].title = editedQuest.quest?.title ?? ""
        self.tableViewData[0].questsData[editedQuest.index!].quest_ref?.updateChildValues([
            "title": editedQuest.quest?.title ?? "",
            "reward":editedQuest.quest?.reward,
            "deadline":editedQuest.quest?.deadline,
            "frequency":editedQuest.quest?.frequency
            ])
        tableView.reloadData()
    }
    
    //DB-related functions
    private func loadQuests(){
        self.tableViewData[0].questsData.removeAll()
        let ref = Database.database().reference().child("quests")
        let userID = Auth.auth().currentUser?.uid
        let query = ref.queryOrdered(byChild: "uid").queryEqual(toValue: userID!)
        query.observe(.value, with: { (snapshot) in
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot{
                    if let newQuest = Quests(snapshot: snapshot) as? Quests{
                self.tableViewData[0].questsData.append(newQuest)
                    }
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editQuest" {
            let path = tableView.indexPathForSelectedRow?.row ?? 0
            let destination = segue.destination as! editQuestViewController
            destination.quest = self.tableViewData[0].questsData[path-1]
            destination.index = path-1
        }
    }
}
