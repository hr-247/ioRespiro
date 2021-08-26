//
//  MenuViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 21/12/2020.
//

import UIKit

class MenuViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //variables
    var headerArr = ["EXTRA","GENERALE","LEGAL"]
    
    
    //outlets
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "", controller: Constant.Controllers.menu, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        tableViewProperty()
        btnLblUI()
    }
    
    func headingUI()
    {
        topHeadingCons.constant = Constant.headingConstraint*UIScreen.main.bounds.height
        headingLbl.text = ""
        headingLbl.font = UIFont.appTitle2
        headingLbl.textColor = UIColor.headingColor
        
    }
    
    func tableViewProperty()
    {
        tableView.register(UINib(nibName: "MenuHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuHeaderTableViewCell")
        tableView.register(UINib(nibName: "DocDashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DocDashboardTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func btnLblUI()
    {
        btnLbl.text = "LOGOUT"
        btnLbl.font = UIFont.btnFont
        btnLbl.textColor = UIColor.headingColor
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
    @IBAction func logoutBtnActn(_ sender: UIButton) {
        
        alertLogout()
        
    }
    

}
extension MenuViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  vw = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderTableViewCell") as! MenuHeaderTableViewCell
        
        vw.midHeaderLbl.isHidden = true
     //   vw.bgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        vw.bgView.backgroundColor = UIColor.patientThemeColor
        vw.headerLbl.text = headerArr[section]
        let font = UIFont(name: AppFontName.ralewayBold, size: 21)!
        vw.headerLblUI(color: .white, font: font)
        
        
        return vw
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocDashboardTableViewCell", for: indexPath) as! DocDashboardTableViewCell
        cell.nextImgView.image = UIImage(named: "nextImg")
        cell.topView.isHidden  = true
        
        
        
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                resizeUI(view: cell.userImgView, width: 30, height: 25)
                cell.userImgView.image = UIImage(named: "menuEdu")
                cell.nameLbl.text = "Educazione"
               // cell.nameLbl.text = "Qualità dell’Aria"
            }
            if indexPath.row == 1
            {
                resizeUI(view: cell.userImgView, width: 30, height: 30)
                cell.userImgView.image = UIImage(named: "PPromemoria")
              //  cell.nameLbl.text = "Stato salute"
                cell.nameLbl.text = "Promemoria"
                
            }
             
        }
        
        if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                resizeUI(view: cell.userImgView, width: 25, height: 28)
                cell.userImgView.image = UIImage(named: "msearchImg")
                cell.nameLbl.text = "Come si usa"
            }
            if indexPath.row == 1
            {
                resizeUI(view: cell.userImgView, width: 20, height: 28)
                cell.userImgView.image = UIImage(named: "bulb")
                cell.nameLbl.text = "Supporto"
            }
             
        }
        if indexPath.section == 2
        {
            if indexPath.row == 0
            {
                resizeUI(view: cell.userImgView, width: 33, height: 35)
                cell.userImgView.image = UIImage(named: "legalImg")
                cell.nameLbl.text = "Legale e Conforme"
            }
            if indexPath.row == 1
            {
                resizeUI(view: cell.userImgView, width: 32, height: 36)
                cell.userImgView.image = UIImage(named: "term")
                cell.nameLbl.text = "Termini e condizioni"
            }
             
        }
        
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let vc = Constant.Controllers.educazione.get() as! EduViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = Constant.Controllers.PPromemoria.get() as! PatientPromemoriaViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if indexPath.section == 2
        {
            if indexPath.row == 1
            {
               openTnC()
            }
            
            
        }
    }
    
   
    
    
}
