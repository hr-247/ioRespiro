//
//  WearableViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 22/02/2021.
//

import UIKit

class WearableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLbl: UILabel!
    
    var headerArr = ["Attività fisica","","Parametri Salute"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: "Stato Salute", controller: Constant.Controllers.wearable, color: .patientThemeColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        tableViewProperty()
        btnLblUI()

    }
    
    func btnLblUI()
    {
        btnLbl.text = "NUOVO PARAMETRO"
        btnLbl.font = UIFont.btnFont
        btnLbl.textColor = .white
    }
    
    func tableViewProperty() {
        tableView.register(UINib(nibName: "WearableTableViewCell", bundle: nil), forCellReuseIdentifier: "WearableTableViewCell")
        tableView.register(UINib(nibName: "MenuHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuHeaderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    

   

}
extension WearableViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 2
        }else if section == 1{
            return 0
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 30
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let  vw = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderTableViewCell") as! MenuHeaderTableViewCell
       vw.headerLbl.isHidden = true
        vw.bgView.isHidden = false
//
        let font =  UIFont(name: AppFontName.ralewayMedium, size: 20)
        vw.midheaderLblUI(font: font!, color: .patientThemeColor)
        vw.midHeaderLbl.text = headerArr[section]
        
        if section == 1{
            vw.bgView.isHidden = true
        }
        if section == 2{
            vw.headerLbl.isHidden = true
            vw.midHeaderLbl.isHidden = true
            vw.lineVw.backgroundColor = .borderColor
            vw.lineVw.isHidden = false
        }
        
       
        return vw
       
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "WearableTableViewCell", for: indexPath) as! WearableTableViewCell
        
        if indexPath.section == 0{
            if indexPath.row == 0{
                cell.mainVwUI(color: .patientThemeColor)
                cell.lblUI(txt: "Corsa")
                cell.imgVw.image = UIImage(named: "wearable1")
            }else{
                cell.mainVwUI(color: .patientThemeColor)
                cell.lblUI(txt: "Work out")
                cell.imgVw.image = UIImage(named: "wearable2")
            }
            
        }else{
            cell.mainVwUI(color: .docShadowColor)
            cell.lblUI(txt: "Frequenza Cardiaca")
            cell.imgVw.image = UIImage(named: "heart2")
        }
   
        return cell
    }
    
    
}
