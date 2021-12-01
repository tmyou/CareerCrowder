//
//  ApplicationsViewController.swift
//  CareerCrowder
//
//  Created by Alan Frank on 10/20/21.
//

import UIKit
import CoreData

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

var companies = [Applications]()

class ApplicationsViewController: UITableViewController, CreateApplication, UISearchResultsUpdating {
    
    var newCompany: String = ""
    var selectedApp = Applications()
    var rowIndex = 0
    
    var firstLoad = true
    
    //Search bar stuff
    var filteredData: [Applications]!

    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companies = []
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        if(firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Applications")
            do
            {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let application = result as! Applications
                    companies.append(application)
                }
            }
            catch
            {
                print("Failed to get data")
            }
        }
        
        //search bar code
        filteredData = companies
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self

        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false

        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar

        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        //search bar code
        
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
        var offers = [Applications]()
        for company in companies
        {
            if company.jobStatus == "Offered"
            {
                offers.append(company)
            }
        }
        offersTab.companiesListApp = offers
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
        //return companies.count
        return filteredData.count
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
        companyNameLabel.text = filteredData[indexPath.row].name
        postionLabel.text = "Position: \(filteredData[indexPath.row].position!)"
        statusLabel.text = "Status: \(filteredData[indexPath.row].jobStatus!)"
        locationLabel.text = "Location: \(filteredData[indexPath.row].location!)"
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
        //selectedApp = companies[indexPath.row]
        selectedApp = filteredData[indexPath.row]
        rowIndex = indexPath.row
        self.performSegue(withIdentifier: "editApp", sender: self)
    }
    
    @IBAction func CreateApplication(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newApp", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            do
            {
                context.delete(companies[indexPath.row])
                companies.remove(at: indexPath.row)
                filteredData = companies
                tableView.deleteRows(at: [indexPath], with: .fade)
                try context.save()
            }
            catch
            {
                print("Failed to delete data")
            }
        }
        tableView.reloadData()
    }
    
    //Search function
    func updateSearchResults(for searchController: UISearchController) {
           if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? companies :  companies.filter({(data: Applications) -> Bool in
                return (data.name.range(of: searchText, options: .caseInsensitive) != nil || data.position.range(of: searchText, options: .caseInsensitive) != nil)
               })

               tableView.reloadData()
           }
       }
        
    func addApp(name: String, jobTitle: String, status: String, locationAddress: String, link: String, dateApp: Date, salary: String, Desc: String)
    {
        //Save application using core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Applications", in: context)
        let newApp = Applications(entity: entity!, insertInto: context)
        newApp.name = name
        newApp.position = jobTitle
        newApp.jobStatus = status
        newApp.location = locationAddress
        newApp.appLink = link
        newApp.salary = salary
        newApp.desc = Desc
        newApp.dateApp = dateApp
        do{
            try context.save()
            companies.append(newApp)
            filteredData = companies
        }
        catch{
            print("context save error")
            let alert = UIAlertController(title: "Error in Saving", message: "Please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }

        tableView.reloadData()
    }
    
    func editApp(name: String, jobTitle: String, status: String, locationAddress: String, link: String, dateApp: Date, salary: String, Desc: String, index: Int, selectedAppToEdit: Applications) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Applications")
        do
        {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let applicationEdited = result as! Applications
                if(selectedAppToEdit == applicationEdited)
                {
                    applicationEdited.name = name
                    applicationEdited.jobStatus = status
                    applicationEdited.location = locationAddress
                    applicationEdited.position = jobTitle
                    applicationEdited.appLink = link
                    applicationEdited.dateApp = dateApp
                    applicationEdited.salary = salary
                    applicationEdited.desc = Desc
                    companies[index] = applicationEdited
                    try context.save()
                    filteredData = companies
                }
            }
        }
        catch
        {
            print("Failed to get data")
        }

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
}
