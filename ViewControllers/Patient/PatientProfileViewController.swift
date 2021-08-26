//
//  PatientProfileViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 18/12/2020.
//

import UIKit

class PatientProfileViewController: UIViewController {
    
    
    //variables
    var dscArr : UserModal?
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Profilo", controller: Constant.Controllers.patientProfile, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        tableViewProperty()
        btnLblUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let token = Utils.getStringForKey(ClassConstants.Datakeys.token)
        {
        getUser(token : token)
        }
    }
    func headingUI()
    {
        topHeadingCons.constant = Constant.headingConstraint*UIScreen.main.bounds.height
        headingLbl.text = "Profilo"
        headingLbl.font = UIFont.appTitle2
        headingLbl.textColor = UIColor.headingColor
    }
    func tableViewProperty(){
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    func profileImgUI()
    {
        profileImg.image = UIImage(named: "profileImg")
        nameLbl.text = "Mario Rossi"
        nameLbl.font = UIFont(name: AppFontName.bold, size: 14)
        nameLbl.textColor = UIColor.textColor
    }
    func btnLblUI()
    {
        btnLbl.text = "MODIFICA"
        btnLbl.font = UIFont.btnFont
        btnLbl.textColor = UIColor.headingColor
    }
    
    
    @IBAction func modifyBtn(_ sender: UIButton) {
        let vc = Constant.Controllers.pProfileModify.get() as! PatientProfileModifyViewController
        vc.dscData = self.dscArr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
 
}
extension PatientProfileViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClassConstants.patientHeadingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        cell.segment.isUserInteractionEnabled = false
        cell.dscTF.isUserInteractionEnabled = false
        cell.labelUI(color: UIColor.patientThemeColor)
        cell.headingLbl.text = ClassConstants.patientHeadingArr[indexPath.row]
        cell.dscTF.isHidden = false
        cell.segment.isHidden = true
        
        if indexPath.row == 0
        {
            cell.dscTF.text = dscArr?.name
        }
        else if indexPath.row == 1
        {
            cell.dscTF.text = dscArr?.email
        }
        else if indexPath.row == 2
        {
            cell.dscTF.text = dscArr?.patient_profile?.date_of_birth ?? ""
        }
   
        else if indexPath.row == 3
        {
            cell.dscTF.isHidden = true
            cell.segment.isHidden = false
            cell.segmentActn(titles: ["UOMO","DONNA"])
        }
        
        else if indexPath.row == 4
        {
           // cell.segmentActn(titles: ["ASMA","BPCO","NON LO SO"])
            cell.dscTF.isHidden = true
            cell.segment.isHidden = false
            cell.segmentActn(titles: ["UOMO","DONNA"])
        }
        if indexPath.row == 5
        {
            if let modal = dscArr?.patient_profile
            {
                cell.dscTF.text = Utils.handleMultiple(modal: modal)

            }
        }
        if indexPath.row == 6
        {
            cell.dscTF.text = dscArr?.patient_profile?.note ?? ""
        }
        if indexPath.row == 7
        {
            cell.dscTF.text = dscArr?.patient_profile?.patient_code
        }
        
        return cell
    }
    
    
}

extension PatientProfileViewController
{
    func getUser(token : String)
    {
        Utils.startLoadingWithTitle("")
        let url = APIManager.APIs.get_Profile
        Service.sharedInstance.getUserProfile(Url: url, token: token , modalName: UserModal.self) { (modal, error) in
            Utils.stopLoading()
            
            if let data = modal
            {
                self.dscArr = data
            }
            self.tableView.reloadData()
                
            }
            
          
        }
}


