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
    }
    var name: String
    var position: String
    var location: String
    var JobStatus: String
}

class ApplicationsViewController: UITableViewController, CreateApplication {
    
    var companies = [Application]()
    var newCompany: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        companies = []
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationCell", for: indexPath)
        let companyNameLabel = cell.viewWithTag(2) as! UILabel
        let postionLabel = cell.viewWithTag(3) as! UILabel
        let statusLabel = cell.viewWithTag(4) as! UILabel
        let locationLabel = cell.viewWithTag(5) as! UILabel
        companyNameLabel.text = companies[indexPath.row].name
        postionLabel.text = companies[indexPath.row].position
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
        
    func addApp(name: String, jobTitle: String, status: String, locationAddress: String)
    {
        var newCompany = Application()
        newCompany.name = name
        newCompany.JobStatus = status
        newCompany.location = locationAddress
        newCompany.position = jobTitle
        companies.append(newCompany)
        tableView.reloadData()
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
