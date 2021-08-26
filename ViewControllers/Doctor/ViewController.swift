//
//  ViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 30/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var btnLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "", controller: Constant.Controllers.docLogout, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        btnLblUI()
      
    }
    
    func btnLblUI()
    {
        btnLbl.text = "LOGOUT"
        btnLbl.font = UIFont.btnFont
        btnLbl.textColor = UIColor.headingColor
    }
    

    
    @IBAction func logOutBtnActn(_ sender: Any) {
        
        alertLogout()
    }
    
}
