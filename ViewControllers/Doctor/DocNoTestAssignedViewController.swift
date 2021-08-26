//
//  DocNoTestAssignedViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 20/01/2021.
//

import UIKit

class DocNoTestAssignedViewController: UIViewController {
    
    //variables
    var batchNo = ""
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var btnLbl: UILabel!
    @IBOutlet weak var noTstAssLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Test", controller: Constant.Controllers.docNoTstAssgnd, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        headingLblUI()
       // noTstAssLbl.isHidden = true
        noTstAssgndLblUI()
        btnLblUI()
    }
    
    func headingLblUI()
    {
        headingLbl.text = batchNo
        headingLbl.font = UIFont(name: AppFontName.ralewayBold, size: 20)
        headingLbl.textColor = UIColor.docThemeColor
    }
    
    func noTstAssgndLblUI()
    {
        noTstAssLbl.text = "NESSUN TEST ASSEGNATO"
        noTstAssLbl.numberOfLines = 2
        noTstAssLbl.font = UIFont.appHeadingBody
        noTstAssLbl.textColor = UIColor.docThemeColor
    }
    
    func btnLblUI()
    {
        btnLbl.text = "ASSEGNA NUOVO TEST"
        btnLbl.font = UIFont.btnFont
        btnLbl.textColor = UIColor.headingColor
    }
    

    @IBAction func testAssgnBtn(_ sender: UIButton) {
        
        let vc = Constant.Controllers.assegnaTest.get() as! AssegnaTestViewController
        vc.batchNo = self.batchNo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
