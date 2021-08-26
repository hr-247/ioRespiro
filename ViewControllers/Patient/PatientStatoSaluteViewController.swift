//
//  PatientStatoSaluteViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 18/02/2021.
//

import UIKit

class PatientStatoSaluteViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    var nameArr = ["APP SALUTE","IMMISSIONE MANUALE"]
    var imgArr = ["heart2","manual"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Stato Salute", controller: Constant.Controllers.patientStato, color: .statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        tableViewProperty()
    }
    
    func tableViewProperty()
    {
        tableView.register(UINib(nibName: "PatientStatoTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientStatoTableViewCell")
        tableView.register(UINib(nibName: "PatientStatoSec2TableViewCell", bundle: nil), forCellReuseIdentifier: "PatientStatoSec2TableViewCell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    

}

extension PatientStatoSaluteViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // Make the background color show through
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientStatoTableViewCell", for: indexPath) as! PatientStatoTableViewCell
            
            cell.headingLblUI(txt: "CONCEDI L’ACCESSO AI DATI", color: .patientThemeColor)
            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatientStatoSec2TableViewCell", for: indexPath) as! PatientStatoSec2TableViewCell
            
            cell.mainViewUI(color: .patientThemeColor)
            
            
            cell.lblUI(txt: nameArr[indexPath.row], color: .white)
            cell.imageVw.image = UIImage(named: imgArr[indexPath.row])
            
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
        if indexPath.row == 0{
            let vc = Constant.Controllers.wearable.get() as! WearableViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
           }
        }
    }
    
    
}
