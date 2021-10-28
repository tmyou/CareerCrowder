//
//  ApplicationDetailViewController.swift
//  CareerCrowder
//
//  Created by Alan Frank on 10/20/21.
//

import UIKit
protocol CreateApplication {
    func addApp(name: String, jobTitle: String, status: String, locationAddress: String, link: String, dateApp: Date, salary: String, Desc: String)
    func editApp(name: String, jobTitle: String, status: String, locationAddress: String, link: String, dateApp: Date, salary: String, Desc: String, index: Int)
}
class ApplicationDetailViewController: UIViewController {
    
    @IBOutlet weak var companyName: UITextField!
    
    @IBOutlet weak var JobTitle: UITextField!
    
    @IBOutlet weak var Status: UITextField!
    
    @IBOutlet weak var Location: UITextField!
    
    @IBOutlet weak var jobLink: UITextField!
    
    @IBOutlet weak var dateApplied: UIDatePicker!
    
    @IBOutlet weak var salary: UITextField!
    
    @IBOutlet weak var jobDesc: UITextField!
    
    var delegate : CreateApplication?
    
    var dayArr = ["Need to Apply", "Applied", "Interviewing", "Offered", "Rejected"]
    var numberOfDay = 0
    
    var name: String = ""
    
    var jobTitle: String = ""
    
    var statusTitle: String = ""
    
    var locationTitle: String = ""

    var dateApp: Date = Date.init()
    
    var link: String = ""
    
    var sal: String = ""
    
    var desc: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func completeApplication(_ sender: Any) {
                if companyName.text?.count == 0 || JobTitle.text?.count == 0 || Location.text?.count == 0 || Status.text?.count == 0
                {
                    let alert = UIAlertController(title: "Empty Text", message: "Please fill out all text fields", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
                    self.present(alert, animated: true, completion: nil)
                }
                else if !dayArr.contains(Status.text!) {
                    let alert = UIAlertController(title: "Invalid Status", message: "Please select a valid status from the button! e.g. Applied", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
                    self.present(alert, animated: true, completion: nil)
                }
               else{
                    name = companyName.text!
                    jobTitle = JobTitle.text!
                    statusTitle = Status.text!
                    locationTitle = Location.text!
                    link = jobLink.text!
                    sal = salary.text!
                    desc = jobDesc.text!
                    dateApp = dateApplied.date
                    delegate?.addApp(name: name, jobTitle: jobTitle, status: statusTitle, locationAddress: locationTitle, link: link, dateApp: dateApp, salary: sal, Desc: desc)
                    self.navigationController?.popViewController(animated: true)
                }
    }
    
    @IBAction func changeStatus(_ sender: Any) {
        let actionSheetAlert = UIAlertController(title: "Pick a Status", message: "", preferredStyle: .actionSheet)
        for dayOfWeek in 0...4 {
            actionSheetAlert.addAction(UIAlertAction(title: "\(dayArr[dayOfWeek])", style: .default, handler: { _ in self.Status.text = "\(self.dayArr[dayOfWeek])"
                self.numberOfDay = dayOfWeek
            }))
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheetAlert.addAction(cancelAction)
        self.present(actionSheetAlert, animated: true, completion: nil)
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
