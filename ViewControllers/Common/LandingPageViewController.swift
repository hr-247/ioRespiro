//
//  LandingPageViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 06/12/2020.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    //variables
    var optionSelected : Bool?
    
    //outlets
    @IBOutlet weak var primoAccessoBtn: UIButton!
    @IBOutlet weak var accediBtn: UIButton!
    @IBOutlet weak var lineView: UIView!
   // @IBOutlet weak var headingTopCons: NSLayoutConstraint!
    @IBOutlet weak var primoBtn: UIButton!
    @IBOutlet weak var accBtn: UIButton!
    
    @IBOutlet weak var bgImgVw: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        commonNavigationBar(title: "", controller: Constant.Controllers.landingPage, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
      //  self.view.backgroundColor = UIColor.white
       // bgImgVw.backgroundColor = UIColor.headingColor
            primoBtnProperty()
            accediBtnProperty()
        //    addBackButton()
            btnUI()
        
    }
    

    func primoBtnProperty()
    {
//        headingTopCons.constant = 0.04*UIScreen.main.bounds.height;
        primoAccessoBtn.setTitle("PRIMO ACCESSO", for: .normal)
        primoAccessoBtn.titleLabel?.font =  UIFont.appHeading
        primoAccessoBtn.setTitleColor(UIColor.patientThemeColor, for: .normal)
        lineView.backgroundColor = UIColor.lineColor
        
    }

    func accediBtnProperty()
    {
        accediBtn.setTitle("ACCEDI", for: .normal)
        accediBtn.titleLabel?.font =  UIFont.appHeading
        accediBtn.setTitleColor(UIColor.patientThemeColor, for: .normal)
    }
    
    func btnUI()
    {
//        primoBtn.setTitle("(REGISTRATION)", for: .normal)
//        primoBtn.titleLabel?.font =  UIFont.appTitle
//        primoBtn.setTitleColor(UIColor.patientThemeColor, for: .normal)
//        accBtn.setTitle("(LOG IN)", for: .normal)
//        accBtn.titleLabel?.font =  UIFont.appTitle
//        accBtn.setTitleColor(UIColor.patientThemeColor, for: .normal)
        
        
        primoBtn.setTitle("", for: .normal)
        primoBtn.titleLabel?.font =  UIFont.appTitle
        primoBtn.setTitleColor(UIColor.patientThemeColor, for: .normal)
        accBtn.setTitle("", for: .normal)
        accBtn.titleLabel?.font =  UIFont.appTitle
        accBtn.setTitleColor(UIColor.patientThemeColor, for: .normal)
    }
    
    
    
    
    
    @IBAction func commonBtnAction(_ sender: UIButton) {
        
        //tag 0 for Accedi and tag 1 for Primo Accesso
        if sender.tag == 0{
            self.optionSelected = false
        }else{
            self.optionSelected = true
        }
        
        let vc = Constant.Controllers.customerType.get() as! CustomerTypeViewController
        vc.selectedOption = self.optionSelected
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
  

}
