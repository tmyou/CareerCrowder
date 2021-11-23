//
//  ApplicationEditViewController.swift
//  CareerCrowder
//
//  Created by student on 10/27/21.
//

import UIKit
import CoreData

class ApplicationEditViewController: UIViewController {
    
    @IBOutlet weak var companyName: UITextField!
    
    @IBOutlet weak var jobTitle: UITextField!
    
    @IBOutlet weak var jobLocation: UITextField!
    
    @IBOutlet weak var status: UITextField!
    
    @IBOutlet weak var jobLink: UITextField!
    
    @IBOutlet weak var dateApp: UIDatePicker!
    
    @IBOutlet weak var salary: UITextField!
    
    @IBOutlet weak var desc: UITextField!
    
    var selectedApp = Applications()
    
    var delegate: CreateApplication?
    var index = 0
    
    var dayArr = ["Need to Apply", "Applied", "Interviewing", "Offered", "Rejected"]
    var numberOfDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyName.text = selectedApp.name
        jobTitle.text = selectedApp.position
        jobLocation.text = selectedApp.location
        status.text = selectedApp.jobStatus
        jobLink.text = selectedApp.appLink
        dateApp.date = selectedApp.dateApp
        salary.text = selectedApp.salary
        desc.text = selectedApp.desc
    }
    
    
    @IBAction func changeStatus(_ sender: Any) {
        let actionSheetAlert = UIAlertController(title: "Pick a Status", message: "", preferredStyle: .actionSheet)
        for dayOfWeek in 0...4 {
            actionSheetAlert.addAction(UIAlertAction(title: "\(dayArr[dayOfWeek])", style: .default, handler: { _ in self.status.text = "\(self.dayArr[dayOfWeek])"
                self.numberOfDay = dayOfWeek
            }))
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheetAlert.addAction(cancelAction)
        self.present(actionSheetAlert, animated: true, completion: nil)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        if companyName.text?.count == 0 || jobTitle.text?.count == 0 || jobLocation.text?.count == 0 || status.text?.count == 0
        {
            let alert = UIAlertController(title: "Empty Text", message: "Please fill out all text fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
        else if !dayArr.contains(status.text!) {
            let alert = UIAlertController(title: "Invalid Status", message: "Please select a valid status from the button! e.g. Applied", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
       else{
        delegate?.editApp(name: companyName.text!, jobTitle: jobTitle.text!, status: status.text!, locationAddress: jobLocation.text!, link: jobLink.text!, dateApp: dateApp.date, salary: salary.text!, Desc: desc.text!, index: index, selectedAppToEdit: selectedApp)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
