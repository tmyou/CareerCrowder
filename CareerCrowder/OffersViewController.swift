//
//  ViewController.swift
//  CareerCrowder
//
//  Created by student on 10/28/21.
//

import UIKit

class OfferViewController: UIViewController {
    
    
    @IBOutlet weak var CompanyName1: UILabel!
    
    @IBOutlet weak var Position1: UILabel!
    
    @IBOutlet weak var Location1: UILabel!
    
    @IBOutlet weak var Salary1: UILabel!
    
    @IBOutlet weak var Desc1: UILabel!
    
    @IBOutlet weak var CompanyName2: UILabel!
    
    @IBOutlet weak var Position2: UILabel!
    
    @IBOutlet weak var Location2: UILabel!
    
    @IBOutlet weak var Salary2: UILabel!
    
    @IBOutlet weak var Desc2: UILabel!
    
    var companiesList = [Applications]()
    var companiesListApp = [Applications]()
    var company1Num = 0
    var company2Num = 0
    var companiesCount = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(companiesListApp)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        companiesList = companiesListApp
        companiesCount = companiesListApp.count
    }
    
    
    @IBAction func selectedOffer1(_ sender: Any) {
        if(companiesList.count > 1){
        let actionSheetAlert = UIAlertController(title: "Pick an application", message: "", preferredStyle: .actionSheet)
        for company in companiesList {
            actionSheetAlert.addAction(UIAlertAction(title: "\(company.name!): \(company.position!)", style: .default, handler: { _ in self.CompanyName1.text = "Company Name: \n\(company.name!)";  self.Position1.text = "Position: \n\(company.position!)"; self.Location1.text = "Location: \n\(company.location!)"; self.Salary1.text = "Salary: \n\(company.salary!)"; self.Desc1.text = "Description: \n\(company.desc!)"
                //self.company1Num = company
            }))
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheetAlert.addAction(cancelAction)
        self.present(actionSheetAlert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Not enough job applications", message: "Please create at least 2 job application to compare!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func selectOffer2(_ sender: Any) {
        if(companiesList.count > 1){
        let actionSheetAlert = UIAlertController(title: "Pick an application", message: "", preferredStyle: .actionSheet)
        for company in companiesList {
            actionSheetAlert.addAction(UIAlertAction(title: "\( company.name!): \(company.position!)", style: .default, handler: { _ in self.CompanyName2.text = "Company Name: \n\(company.name!)";  self.Position2.text = "Position: \n\(company.position!)"; self.Location2.text = "Location: \n\(company.location!)"; self.Salary2.text = "Salary: \n\(company.salary!)"; self.Desc2.text = "Description: \n\(company.desc!)"
            }))
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheetAlert.addAction(cancelAction)
        self.present(actionSheetAlert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Not enough job applications", message: "Please create at least 2 job application to compare!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
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
