//
//  ApplicationsViewController.swift
//  CareerCrowder
//
//  Created by Alan Frank on 10/20/21.
//

import UIKit

struct Application{
    init(){
        name = ""
        position = ""
        location = ""
        JobStatus = ""
        appLink = ""
        dateApp = Date.init()
        salary = ""
        desc = ""
    }
    var name: String
    var position: String
    var location: String
    var JobStatus: String
    var appLink: String
    var dateApp: Date
    var salary: String
    var desc: String
}

class ApplicationsViewController: UITableViewController, CreateApplication {
    
    var companies = [Application]()
    var newCompany: String = ""
    var selectedApp = Application()
    var rowIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companies = []
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let backBarBtnItem = UIBarButtonItem()
            backBarBtnItem.title = "Cancel"
        backBarBtnItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarBtnItem
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            let altCellColor: UIColor? = UIColor(red: 0.20, green: 0.88, blue: 0.77, alpha: 0.6)
            cell.backgroundColor = altCellColor
        }
        else {
            let alt2CellColor: UIColor? = UIColor(red: 0.05, green: 0.45, blue: 0.47, alpha: 0.6)
            cell.backgroundColor = alt2CellColor
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let nav = self.tabBarController?.viewControllers![2] as! UINavigationController
        let offersTab = nav.topViewController as! OfferViewController
        offersTab.companiesListApp = companies
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // TODO: FIX for deletion bugs
//        var numOfSections: Int = 0
//        if companies.count > 0
//        {
//            tableView.separatorStyle = .singleLine
//            numOfSections            = 1
//            tableView.backgroundView = nil
//        }
//        else
//        {
//            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//            noDataLabel.text          = "No applications"
//            noDataLabel.textColor     = UIColor.black
//            noDataLabel.textAlignment = .center
//            tableView.backgroundView  = noDataLabel
//            tableView.separatorStyle  = .none
//        }
//        return numOfSections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationCell", for: indexPath)
        let companyNameLabel = cell.viewWithTag(2) as! UILabel
        let postionLabel = cell.viewWithTag(3) as! UILabel
        let statusLabel = cell.viewWithTag(4) as! UILabel
        let locationLabel = cell.viewWithTag(5) as! UILabel
        companyNameLabel.text = companies[indexPath.row].name
        postionLabel.text = "Position: \(companies[indexPath.row].position)"
        statusLabel.text = "Status: \(companies[indexPath.row].JobStatus)"
        locationLabel.text = "Location: \(companies[indexPath.row].location)"
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newApp"
        {
            let createAppSegue = segue.destination as! ApplicationDetailViewController
            
            createAppSegue.delegate = self
        }
        else if segue.identifier == "editApp"
        {
            let editAppSegue = segue.destination as! ApplicationEditViewController
            editAppSegue.delegate = self
            editAppSegue.selectedApp = selectedApp
            editAppSegue.index = rowIndex
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedApp = companies[indexPath.row]
        rowIndex = indexPath.row
        self.performSegue(withIdentifier: "editApp", sender: self)
    }
    
    @IBAction func CreateApplication(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newApp", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            companies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
        
    func addApp(name: String, jobTitle: String, status: String, locationAddress: String, link: String, dateApp: Date, salary: String, Desc: String)
    {
        var newCompany = Application()
        newCompany.name = name
        newCompany.JobStatus = status
        newCompany.location = locationAddress
        newCompany.position = jobTitle
        newCompany.appLink = link
        newCompany.dateApp = dateApp
        newCompany.salary = salary
        newCompany.desc = Desc
        print(newCompany)
        companies.append(newCompany)
        tableView.reloadData()
    }
    
    func editApp(name: String, jobTitle: String, status: String, locationAddress: String, link: String, dateApp: Date, salary: String, Desc: String, index: Int) {
        var editedCompany = Application()
        editedCompany.name = name
        editedCompany.JobStatus = status
        editedCompany.location = locationAddress
        editedCompany.position = jobTitle
        editedCompany.appLink = link
        editedCompany.dateApp = dateApp
        editedCompany.salary = salary
        editedCompany.desc = Desc
        companies[index] = editedCompany
        tableView.reloadData()
    }
    
    func ifNumber(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if companies.count > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
