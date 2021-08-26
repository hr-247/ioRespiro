//
//  AddPatientPromemoriaViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 17/12/2020.
//

import UIKit

class AddPatientPromemoriaViewController: UIViewController {
    
    //variables
    var dataArr = ["Titolo","08/12/2020","12:00"]
    
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var btnLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Promemoria", controller: Constant.Controllers.addPatientPromemoria, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
      //  headingUI()
        tableViewProperty()
        btnUI()
     //   addBackButton()
    }
    
    func headingUI(){
        topHeadingCons.constant = Constant.headingConstraint*UIScreen.main.bounds.height
        headingLbl.text = "Promemoria"
        headingLbl.font = UIFont.appTitle2
        headingLbl.textColor = UIColor.headingColor
    }
    
    func tableViewProperty()
    {
        tableView.register(UINib(nibName: "AddPromemoriaTableViewCell", bundle: nil), forCellReuseIdentifier: "AddPromemoriaTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func btnUI()
    {
        btnLbl.text = "CONFERMA"
        btnLbl.textColor = UIColor.headingColor
        btnLbl.font =  UIFont.btnFont
    }

    

}
extension AddPatientPromemoriaViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddPromemoriaTableViewCell", for: indexPath) as! AddPromemoriaTableViewCell
        cell.ansLbl.isHidden = true
        cell.lblUI(txt: dataArr[indexPath.row], color: UIColor.black,font: UIFont.textFont)
       
        if indexPath.row == 0
        {
            cell.lbl.font = UIFont.txtFontBold
        }
        
        
        return cell
    
    }
    
    
}
