//
//  ViewController.swift
//  CareerCrowder
//
//  Created by student on 10/28/21.
//

import UIKit



class OfferViewController: UIViewController {
    
    // ------------------------------------------------------------------------
    
    @IBOutlet var btnSelectOffer1: UIButton!
    
    @IBOutlet var btnSelectOffer2: UIButton!
    
    let transparentView = UIView()
    let ststableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    
    // ------------------------------------------------------------------------
    
    
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
        // ------------------------------------------------------------------------
        
        ststableView.delegate = self
        ststableView.dataSource = self
        ststableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        print(companiesList.count)
        //btnSelectStatus.titleLabel?.font = UIFont(name: "Lato-Regular", size: 25)
        
        // ------------------------------------------------------------------------
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataSource = [String]()
        companiesList = companiesListApp
        companiesCount = companiesListApp.count
        clearPage()
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
        if selectedButton == btnSelectOffer1 {
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0.5
                self.ststableView.frame = CGRect(x: frames.origin.x - 10, y: frames.origin.y + frames.height + 70, width: frames.width + 220, height: 150)
            }, completion: nil)
        }
        if selectedButton == btnSelectOffer2 {
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0.5
                self.ststableView.frame = CGRect(x: frames.origin.x - 210, y: frames.origin.y + frames.height + 70, width: frames.width + 220, height: 150)
            }, completion: nil)
        }
        
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0.0
            self.ststableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    // ------------------------------------------------------------------------
    
    @IBAction func selectedOffer1(_ sender: Any) {
        if(companiesList.count > 1){
            for company in companiesList {
                if !dataSource.contains("\(company.name!): \(company.position!)") {
                    dataSource.append("\(company.name!): \(company.position!)")
                }
            }
            selectedButton = btnSelectOffer1
            addTransparentView(frames: btnSelectOffer1.frame)
        }
        else{
            let alert = UIAlertController(title: "Not enough offers", message: "You need at least 2 job offers to compare!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func selectOffer2(_ sender: Any) {
        if(companiesList.count > 1){
            for company in companiesList {
                if !dataSource.contains("\(company.name!): \(company.position!)") {
                    dataSource.append("\(company.name!): \(company.position!)")
                }
            }
            selectedButton = btnSelectOffer2
            addTransparentView(frames: btnSelectOffer2.frame)
        }
        else{
            let alert = UIAlertController(title: "Not enough offers", message: "You need at least 2 job offers to compare!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func clearPage ()
    {
        CompanyName1.text = ""
        Position1.text = ""
        Location1.text = ""
        Salary1.text = ""
        Desc1.text = ""
        btnSelectOffer1.setTitle("Select Offer", for: .normal)
        CompanyName2.text = ""
        Position2.text = ""
        Location2.text = ""
        Salary2.text = ""
        Desc2.text = ""
        btnSelectOffer2.setTitle("Select Offer", for: .normal)
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

// ------------------------------------------------------------------------

extension OfferViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ststableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
     }

     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let attributedTitle = btnSelectStatus.attributedTitle(for: .normal) {
//            let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
//            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: dataSource[indexPath.row])
//            btnSelectStatus.setAttributedTitle(mutableAttributedTitle, for: .normal)
//            //btnSelectStatus.setTitleColor(UIColor.red, for: .normal)
//            //btnSelectStatus.titleLabel?.font = UIFont(name: "Lato-Regular", size: 25)
//        }
//        //selectedButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 25)
//        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        
        if selectedButton == btnSelectOffer1 {
            let splitarr = String(dataSource[indexPath.row]).components(separatedBy: ": ")
            for company in companiesList {
                if (company.name == splitarr[0]) && (company.position == splitarr[1]) {
                    CompanyName1.text = "Company Name: \n\(company.name!)";  Position1.text = "Position: \n\(company.position!)"; Location1.text = "Location: \n\(company.location!)"; Salary1.text = "Salary: \n\(company.salary!)"; Desc1.text = "Description: \n\(company.desc!)"
                    btnSelectOffer1.setTitle(company.name, for: .normal)
                }
                
            }
            
        }
        if selectedButton == btnSelectOffer2 {
            let splitarr = String(dataSource[indexPath.row]).components(separatedBy: ": ")
            for company in companiesList {
                if (company.name == splitarr[0]) && (company.position == splitarr[1]) {
                    CompanyName2.text = "Company Name: \n\(company.name!)";  Position2.text = "Position: \n\(company.position!)"; Location2.text = "Location: \n\(company.location!)"; Salary2.text = "Salary: \n\(company.salary!)"; Desc2.text = "Description: \n\(company.desc!)"
                    btnSelectOffer2.setTitle(company.name, for: .normal)
                }
                
            }
        }
        removeTransparentView()
    }
}

// ------------------------------------------------------------------------
