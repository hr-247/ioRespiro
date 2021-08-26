//
//  TestViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 10/12/2020.
//

import UIKit

class TestViewController: UIViewController {
    
    //outlets
   // @IBOutlet weak var topLblCons: NSLayoutConstraint!
    @IBOutlet weak var testTaiBtn: UIButton!
    @IBOutlet weak var testCatBtn: UIButton!
  //  @IBOutlet weak var headingLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Test", controller: Constant.Controllers.test, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
      
     //   ui()
        testTaiBtnProperty()
        testCatBtnProperty()
      //  addBackButton()

    }
//    func ui()
//    {
//        topLblCons.constant = 0.04*UIScreen.main.bounds.height
//        headingLbl.text = "Test"
//        headingLbl.textColor = UIColor.headingColor
//        headingLbl.font = UIFont.appTitle2
//
//    }
    
    func testTaiBtnProperty()
    {
        testTaiBtn.setTitle("TEST TAI", for: .normal)
        testTaiBtn.titleLabel?.font =  UIFont.appHeading
        testTaiBtn.setTitleColor(UIColor.patientThemeColor, for: .normal)
     
        
    }

    func testCatBtnProperty()
    {
        testCatBtn.setTitle("TEST CAT", for: .normal)
        testCatBtn.titleLabel?.font =  UIFont.appHeading
        testCatBtn.setTitleColor(UIColor.patientThemeColor, for: .normal)
    }
    
    
    @IBAction func testTaiBtnActn(_ sender: UIButton) {
        let vc = Constant.Controllers.testTai.get() as! TestTaiViewController
        vc.whchBtnClckd = false
        vc.type = .tai
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func testCatBtnActn(_ sender: UIButton) {
        let vc = Constant.Controllers.testTai.get() as! TestTaiViewController
        vc.whchBtnClckd = true
        vc.type = .cat
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
