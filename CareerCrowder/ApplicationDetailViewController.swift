//
//  ApplicationDetailViewController.swift
//  CareerCrowder
//
//  Created by Alan Frank on 10/20/21.
//

import UIKit
import CoreData

// ------------------------------------------------------------------------

class CellClass: UITableViewCell {
    
}

// ------------------------------------------------------------------------

protocol CreateApplication {
    func addApp(name: String, jobTitle: String, status: String, locationAddress: String, link: String, dateApp: Date, salary: String, Desc: String)
    func editApp(name: String, jobTitle: String, status: String, locationAddress: String, link: String, dateApp: Date, salary: String, Desc: String, index: Int, selectedAppToEdit: Applications)
}
class ApplicationDetailViewController: UIViewController {
    
    // ------------------------------------------------------------------------
    
    @IBOutlet var btnSelectStatus: UIButton!
    
    
    let transparentView = UIView()
    let ststableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    
    // ------------------------------------------------------------------------
    
    @IBOutlet weak var companyName: UITextField!
    
    @IBOutlet weak var JobTitle: UITextField!
    
    @IBOutlet weak var Location: UITextField!
    
    @IBOutlet weak var jobLink: UITextField!
    
    @IBOutlet weak var dateApplied: UIDatePicker!
    
    @IBOutlet weak var salary: UITextField!
    
    @IBOutlet weak var jobDesc: UITextField!
    
    var delegate : CreateApplication?
    
    var statusArray = ["Need to Apply", "Applied", "Interviewing", "Offered", "Rejected"]
    
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
        let backBarBtnItem = UIBarButtonItem()
            backBarBtnItem.title = "something different"
            navigationItem.backBarButtonItem = backBarBtnItem
        // Do any additional setup after loading the view.
        
        // ------------------------------------------------------------------------
        
        ststableView.delegate = self
        ststableView.dataSource = self
        ststableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        btnSelectStatus.titleLabel?.font = UIFont(name: "Lato-Regular", size: 25)
        
        // ------------------------------------------------------------------------
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let backBarBtnItem = UIBarButtonItem()
            backBarBtnItem.title = "something different"
        self.navigationItem.backBarButtonItem = backBarBtnItem
    }
    
    @IBAction func completeApplication(_ sender: Any) {
        if companyName.text?.count == 0 || JobTitle.text?.count == 0 || Location.text?.count == 0                 {
                    let alert = UIAlertController(title: "Empty Text Field", message: "Please fill out all text fields", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
                    self.present(alert, animated: true, completion: nil)
                }
        else if !statusArray.contains(btnSelectStatus.titleLabel?.text ?? "")  {
            let alert = UIAlertController(title: "Select Status", message: "Please select an application status", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
               else{
                    name = companyName.text!
                    jobTitle = JobTitle.text!
                   // ------------------------------------------------------------------------
                   statusTitle = (selectedButton.titleLabel?.text)!
                   // ------------------------------------------------------------------------
                    locationTitle = Location.text!
                    link = jobLink.text!
                    sal = salary.text!
                    desc = jobDesc.text!
                    dateApp = dateApplied.date
                    delegate?.addApp(name: name, jobTitle: jobTitle, status: statusTitle, locationAddress: locationTitle, link: link, dateApp: dateApp, salary: sal, Desc: desc)
                    self.navigationController?.popViewController(animated: true)
                }
    }
    // ------------------------------------------------------------------------
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        ststableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(ststableView)
        ststableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        ststableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0.5
            self.ststableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 150)
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0.0
            self.ststableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func onClickSelectStatus(_ sender: Any) {
        dataSource = ["Need to Apply", "Applied", "Interviewing", "Offered", "Rejected"]
        selectedButton = btnSelectStatus
        addTransparentView(frames: btnSelectStatus.frame)
    }
    
    // ------------------------------------------------------------------------
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// ------------------------------------------------------------------------

extension ApplicationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ststableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let attributedTitle = btnSelectStatus.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: dataSource[indexPath.row])
            btnSelectStatus.setAttributedTitle(mutableAttributedTitle, for: .normal)
        }
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}

// ------------------------------------------------------------------------
