//
//  StatoSaluteViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 16/12/2020.
//

import UIKit

class StatoSaluteViewController: UIViewController {
    
    //variables
    var numArr = ["xx","xx",]
    var batchNumber = ""
    var headerArr = ["Attività fisica","","Parametri Salute"]
    
    //outltes
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var saluteTableView: UITableView!
    @IBOutlet weak var btnLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: "STATO SALUTE", controller: Constant.Controllers.stato, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        tableViewProperty()
        btnLblUI()
        headingUI()
    }
    
    func headingUI(){
      //  topHeadingCons.constant = 0.04*UIScreen.main.bounds.height
        headingLbl.text = batchNumber
        headingLbl.textColor = UIColor.docThemeColor
        headingLbl.font = UIFont(name: AppFontName.ralewayBold, size: 20)
        
    }
    
    func tableViewProperty(){
        saluteTableView.register(UINib(nibName: "WearableTableViewCell", bundle: nil), forCellReuseIdentifier: "WearableTableViewCell")
        saluteTableView.register(UINib(nibName: "MenuHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuHeaderTableViewCell")
        
        saluteTableView.delegate = self
        saluteTableView.dataSource = self
        
    }
    func btnLblUI(){
       
        btnLbl.text = "NUOVO PARAMETRO"
        btnLbl.textColor = UIColor.headingColor
        btnLbl.font = UIFont.btnFont
        
    }
    

    @IBAction func btnActn(_ sender: UIButton) {
        let vc = Constant.Controllers.addStato.get() as! AddStatoSaluteViewController
        vc.batchNumber = self.batchNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension StatoSaluteViewController : UITableViewDelegate, UITableViewDataSource
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
//
        let font =  UIFont(name: AppFontName.ralewayMedium, size: 20)
        vw.midheaderLblUI(font: font!, color: .docShadowColor)
        vw.midHeaderLbl.text = headerArr[section]
        
        if section == 1{
            vw.bgView.isHidden = true
        }else if section == 2{
            vw.lineVw.backgroundColor = .borderColor
            vw.lineVw.isHidden = false   
        }
        
        return vw
       
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WearableTableViewCell", for: indexPath) as! WearableTableViewCell
        
        if indexPath.section == 0{
            if indexPath.row == 0{
                cell.mainVwUI(color: .docShadowColor)
                cell.lblUI(txt: "Corsa")
                cell.imgVw.image = UIImage(named: "wearable1")
            }else{
                cell.mainVwUI(color: .docShadowColor)
                cell.lblUI(txt: "Passi")
                cell.imgVw.image = UIImage(named: "wearable2")
            }
            
        }else{
            cell.mainVwUI(color: .docShadowColor)
            cell.lblUI(txt: "Frequenza Cardiaca")
            cell.imgVw.image = UIImage(named: "wearable3")
        }
        
        return cell
    }
    
    
}
