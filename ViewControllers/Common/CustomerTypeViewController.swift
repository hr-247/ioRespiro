//
//  CustomerTypeViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 06/12/2020.
//

import UIKit

class CustomerTypeViewController: UIViewController {
    
    //variables
    var selectedOption : Bool?
    
    //outlets
    @IBOutlet weak var lineView: UIView!
  //  @IBOutlet weak var headingTopCons: NSLayoutConstraint!
    @IBOutlet weak var medicLbl: UILabel!
    @IBOutlet weak var pazentLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        displayUI()
     //   addBackButton()
       


        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        commonNavigationBar(title: "", controller: Constant.Controllers.customerType, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
    }
    
    
    func displayUI()
    {
        medicLbl.text = "MEDICO"
        medicLbl.font = UIFont(name: AppFontName.bold, size: 22)
        medicLbl.textColor = UIColor.docThemeColor
        
        pazentLbl.text = "PAZIENTE"
        pazentLbl.font = UIFont(name: AppFontName.bold, size: 22)
        pazentLbl.textColor = UIColor.patientThemeColor
        
        
        lineView.backgroundColor = UIColor.lineColor
//        headingTopCons.constant = 0.04*UIScreen.main.bounds.height
        
    }
    
    

    @IBAction func doctorSelected(_ sender: UIButton) {
        if self.selectedOption == true{
            let vc = Constant.Controllers.docRegistration.get() as! DocRegistrationViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            let vc = Constant.Controllers.docLogin.get() as! DocLoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
    @IBAction func patientSelected(_ sender: UIButton) {
        if self.selectedOption == false{
            let vc = Constant.Controllers.patientLogin.get() as! PatientLoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            let vc = Constant.Controllers.patientRegistration.get() as! PatientRegistrationViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    

}
