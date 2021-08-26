//
//  DocDashboardViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 09/12/2020.
//

import UIKit

class DocDashboardViewController: UIViewController, DocDashBtnTableViewCellDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var centerLbl: UILabel!
    //variables
    var code = ""
    var patientArray = [UserModal]()
    var tempArray = [UserModal]()

    var index = 0
    
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var headingTopCons: NSLayoutConstraint!
    @IBOutlet weak var docDashTableView: UITableView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var searchImgV: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        commonNavigationBar(title: "Pazienti", controller: Constant.Controllers.docDashboard, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
       // headingUI()
        tableViewProperty()
        searchTxtFieldUI()
        noPatientUI()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPatientListFromServer()
    }
    
    func headingUI(){
        headingTopCons.constant = 0.04*UIScreen.main.bounds.height
        headingLbl.text = "Pazienti"
        headingLbl.textColor = UIColor.headingColor
        headingLbl.font = UIFont.appTitle2
        
    }
    
    
    func noPatientUI()
    {
        centerLbl.text = "NESSUN PAZIENTE AGGIUNTO"
        centerLbl.numberOfLines = 2
        centerLbl.font = UIFont.appHeadingBody
        centerLbl.textColor = UIColor.docThemeColor
        centerLbl.isHidden = true
    }
    
    func tableViewProperty(){
        docDashTableView.register(UINib(nibName: "DocDashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DocDashboardTableViewCell")
        docDashTableView.register(UINib(nibName: "DocDashBtnTableViewCell", bundle: nil), forCellReuseIdentifier: "DocDashBtnTableViewCell")
        docDashTableView.delegate = self
        docDashTableView.dataSource = self
        
    }
    
    func searchTxtFieldUI()
    {
        searchTxtField.setLeftPaddingPoints(40)
        searchTxtField.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
        searchTxtField.attributedPlaceholder = NSAttributedString(string: "Cerca", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lineColor])
        
        
        searchTxtField.font = UIFont(name: AppFontName.ralewayMedium, size: 16)
        searchTxtField.layer.cornerRadius = 21
        searchTxtField.layer.borderWidth = 1
        searchTxtField.layer.borderColor
            = UIColor(red: 204/255, green: 202/255, blue: 202/255, alpha: 1).cgColor
    }
    
    @objc func textFieldTextDidChange()
    {
        
        patientArray = tempArray

        if let text = searchTxtField.text
        {
            if text.isEmpty == false {
            
            patientArray =  tempArray.filter { (user) -> Bool in
                return ((user.name?.contains(text) ?? false) || (user.patient_profile?.name?.contains(text) ?? false) || (user.patient_profile?.patient_code?.contains(text) ?? false))
            }
            }
            
        }
        
       
        
        self.docDashTableView.reloadData()
    
        
    }
    
    func nuovoPazienteActn() {
        let vc =  Constant.Controllers.home1.get() as! Home1ViewController
       // vc.nameLbl = self.code
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true);
        print("view did appear");
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        
    }

    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {

        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer)
        {
            if (self.navigationController?.viewControllers.count ?? 0 > 1)
            {
                return true
            }

            return false
        }

        return true
    }
    
    
    
}
extension DocDashboardViewController : UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return patientArray.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DocDashboardTableViewCell", for: indexPath) as! DocDashboardTableViewCell
            
            if let code = self.patientArray[indexPath.row].name
            {
            cell.lblUI(title: code)
            }
            
            if indexPath.row == 0 {
                cell.topView.isHidden = false
            }else{
                cell.topView.isHidden = true
            }
            return cell
            
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DocDashBtnTableViewCell", for: indexPath) as! DocDashBtnTableViewCell
            cell.lblUI(txt: "NUOVO PAZIENTE")
            cell.delegate = self
            return cell
            
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  Constant.Controllers.doctorDash.get() as! DoctorDashboardViewController
        if let name = self.patientArray[indexPath.row].name
        {
            vc.batchNumber = name

        }
        if let code = self.patientArray[indexPath.row].patient_profile?.patient_code
        {
            Utils.saveStringForKey(key: ClassConstants.Datakeys.patientCode, value: code)
        }
        
        if let patientId = self.patientArray[indexPath.row].id
        {
           AppUtils.AppDelegate().patientId = patientId

        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension DocDashboardViewController
{
    
    func getPatientListFromServer()
    {
   
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Linked_Patient, modalName: [UserModal].self) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil
            {
             //   let array = modal!
                self.patientArray.removeAll()
                self.tempArray.removeAll()
                var seen = Set<String>()
                for item in modal! {
                    if let code = item.name
                    {
                        
                        if !seen.contains(code) {
                            self.patientArray.append(item)
                            self.tempArray.append(item)
                            seen.insert(code)
                        }
                    }
                }
            }
            if self.patientArray.count > 0
            {
                self.centerLbl.isHidden = true
               
                
            }else
            {
                self.searchTxtField.isHidden = true
                self.searchImgV.isHidden = true
                self.docDashTableView.isHidden = true
                self.centerLbl.isHidden = false
            }
            
            
            self.docDashTableView.reloadData()
        
            }
       
    }
   
}




