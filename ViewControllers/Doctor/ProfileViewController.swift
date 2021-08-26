//
//  ProfileViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 15/12/2020.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //variables
    var userModal = ProfileModal()
    var batchHeading = ""
    
    //outlets
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var btnLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: batchHeading, controller: Constant.Controllers.profile, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        tableViewProperty()
        lblUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let code = Utils.getStringForKey(ClassConstants.Datakeys.patientCode)
        {
            getUser(patientCode : code)
        }
    }
    
    func headingUI(){
        topHeadingCons.constant = 0.04*UIScreen.main.bounds.height
        headingLbl.text = "Codice 1"
        headingLbl.textColor = UIColor.headingColor
        headingLbl.font = UIFont.appTitle2
        
    }
    
    
    @IBAction func btnACtion(_ sender: Any) {
        let vc = Constant.Controllers.stato.get() as! StatoSaluteViewController
        vc.batchNumber = batchHeading
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    func lblUI()
    {
        btnLbl.text = "STATO DI SALUTE"
        btnLbl.textColor = UIColor.headingColor
        btnLbl.font = UIFont.btnFont
        
    }
    
    func tableViewProperty(){
        profileTableView.layer.cornerRadius = 20
        profileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        //0    profileTableView.register(UINib(nibName: "DocDashBtnTableViewCell", bundle: nil), forCellReuseIdentifier: "DocDashBtnTableViewCell")
    
        
    }
    
    
}
extension ProfileViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //     if section == 0
        //     {
        return ClassConstants.headingArr.count
        //     }else{
        //        return 0
        //     }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        if indexPath.section == 0
        //        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        cell.segment.isHidden = true
        cell.headingLbl.text = ClassConstants.headingArr[indexPath.row]
        cell.labelUI(color: UIColor.docThemeColor)
        cell.dscTF.isUserInteractionEnabled = false
        cell.segment.isUserInteractionEnabled = false
        
        if indexPath.row == 0
        {
            // cell.dscTF.tag = 301
            cell.dscTF.text = self.userModal.name
        }
        else if indexPath.row == 1
        {
            
            cell.dscTF.text = self.userModal.date_of_birth ?? ""
        }
        
        else if indexPath.row == 2
        {
            
            
            cell.dscTF.text = self.userModal.sex ?? "UOMO"
        }
        
        else if indexPath.row == 3
        {
            
            
            cell.dscTF.text =  self.userModal.patologie_respiratorie ?? "ASMA"
            
        }
        if indexPath.row == 4
        {

                cell.dscTF.text = Utils.handleMultiple(modal: self.userModal)
   
        }
        if indexPath.row == 5
        {
            //    cell.dscTF.tag = 306
            cell.dscTF.text = self.userModal.note ?? ""
        }
        if indexPath.row == 6
        {
            
            cell.dscTF.text = self.userModal.patient_code
        }
        
        
        
        
        return cell
        //        }else{
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "DocDashBtnTableViewCell", for: indexPath) as! DocDashBtnTableViewCell
        //            cell.backgroundColor = UIColor.clear
        //            cell.lblUI(txt: "STATO DI SALUTE")
        //          //  cell.delegate = self
        //
        //
        //            return cell
        //        }
    }
    
    
}
//extension ProfileViewController : DocDashBtnTableViewCellDelegate
//{
//    func nuovoPazienteActn() {
//        let vc = Constant.Controllers.stato.get() as! StatoSaluteViewController
//        vc.batchNumber = batchHeading
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    
//}

extension ProfileViewController
{
    func getUser(patientCode : String)
    {
        Utils.startLoadingWithTitle("")
        let url = APIManager.APIs.patientProfile_Dr_Side
        
        let post : [String : Any] = ["patientCode" : patientCode]
        Service.sharedInstance.postJSONRequest(Url: url, modalName: ProfileFrmDrSide.self, parameter: post) { (modal, error) in
            
            Utils.stopLoading()
            
            guard let data =  modal
            else  {
                AppUtils.showToast(message: Constant.Msg.errorMsg)
                return
            }
            
            if let arr = data.results
            {
          //  self.dscArr = arr
                if arr.count > 0
                {
                    self.userModal = arr[0]
                }
            }
            
            self.profileTableView.delegate = self
            self.profileTableView.dataSource = self
            
            
           
            self.profileTableView.reloadData()
            
        }
        
        
    }
    
    
}
