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
    
    @IBOutlet weak var jobLink: UITextField!
    
    @IBOutlet weak var dateApp: UIDatePicker!
    
    @IBOutlet weak var salary: UITextField!
    
    @IBOutlet weak var desc: UITextField!
    
    @IBOutlet weak var editSaveButton: UIBarButtonItem!
    
    
    @IBOutlet weak var jobUrL: UITextView!
    // ------------------------------------------------------------------------
    
    @IBOutlet var btnSelectStatus: UIButton!
    
    
    let transparentView = UIView()
    let ststableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    
    // ------------------------------------------------------------------------
    
    var selectedApp = Applications()
    
    var delegate: CreateApplication?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyName.text = selectedApp.name
        jobTitle.text = selectedApp.position
        jobLocation.text = selectedApp.location
        //status.text = selectedApp.jobStatus
        btnSelectStatus.setTitle(selectedApp.jobStatus, for: .normal)
        //btnSelectStatus.titleLabel?.text = selectedApp.jobStatus
        jobLink.text = selectedApp.appLink
        dateApp.date = selectedApp.dateApp
        salary.text = selectedApp.salary
        desc.text = selectedApp.desc
        jobUrL.text = selectedApp.appLink
        if selectedApp.appLink == ""{
            jobUrL.text = "Link to Job Application"
            jobUrL.textColor = UIColor.lightGray
        }
        
        //Makes it uneditable
        self.editSaveButton.title = "Edit"
        self.companyName.isEnabled = false
        self.jobTitle.isEnabled = false
        self.jobLocation.isEnabled = false
        self.jobLink.isEnabled = false
        self.jobLink.isHidden = true
        self.dateApp.isEnabled = false
        self.salary.isEnabled = false
        self.desc.isEnabled = false
        self.btnSelectStatus.isEnabled = false
        self.jobUrL.isEditable = false
        //Makes it uneditable
        
        // ------------------------------------------------------------------------
        
        ststableView.delegate = self
        ststableView.dataSource = self
        ststableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        //btnSelectStatus.titleLabel?.font = UIFont(name: "Lato-Regular", size: 25)
        
        // ------------------------------------------------------------------------
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        //Button pressed to create changes
        self.isEditing = !self.isEditing
        if self.isEditing
        {
            self.title = "Edit Application"
            self.editSaveButton.title = "Save"
            self.companyName.isEnabled = true
            self.jobTitle.isEnabled = true
            self.jobLocation.isEnabled = true
            self.jobLink.isEnabled = true
            self.jobLink.isHidden = false
            self.dateApp.isEnabled = true
            self.salary.isEnabled = true
            self.desc.isEnabled = true
            self.btnSelectStatus.isEnabled = true
            self.jobUrL.isHidden = true
                 }
         else{
                if companyName.text?.count == 0 || jobTitle.text?.count == 0 || jobLocation.text?.count == 0
                    {
                        let alert = UIAlertController(title: "Empty Text", message: "Please fill out all text fields", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
                        self.present(alert, animated: true, completion: nil)
                    }
            
                    else if btnSelectStatus.titleLabel?.text == "Select Status..." {
                        let alert = UIAlertController(title: "Select Status", message: "Please select an application status", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
                        self.present(alert, animated: true, completion: nil)
                    }
            
                else
                {
                    delegate?.editApp(name: companyName.text!, jobTitle: jobTitle.text!, status: (btnSelectStatus.titleLabel?.text)!, locationAddress: jobLocation.text!, link: jobLink.text!, dateApp: dateApp.date, salary: salary.text!, Desc: desc.text!, index: index, selectedAppToEdit: selectedApp)
                        self.navigationController?.popViewController(animated: true)
                }
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
    
}

// ------------------------------------------------------------------------

extension ApplicationEditViewController: UITableViewDelegate, UITableViewDataSource {
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
