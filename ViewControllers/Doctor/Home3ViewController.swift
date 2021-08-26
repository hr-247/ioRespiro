//
//  Home3ViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 11/12/2020.
//

import UIKit

class Home3ViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var subHeadingLbl: UILabel!
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var imgHeightCons: NSLayoutConstraint!
    @IBOutlet weak var btnLbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var tabVw: UIView!
    @IBOutlet weak var pazienteBtn: UIButton!
    @IBOutlet weak var newPazienteBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  headingLblUI()
        commonNavigationBar(title: "", controller: Constant.Controllers.home3, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        subHeadingLblUI()
        btnLbl.isHidden = true
      //  btnLblUI()
        btnUI()
     //   btn.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    
    func headingLblUI()
    {
        imgHeightCons.constant = 0.45*UIScreen.main.bounds.height;
        topHeadingCons.constant = 0.04*UIScreen.main.bounds.height;
        headingLbl.text = "Home"
        headingLbl.textColor = UIColor.headingColor
        headingLbl.font = UIFont.appTitle2
    }
    
    func btnUI()
    {
        self.imgView.backgroundColor = .appBackgroundColor
        self.view.backgroundColor = UIColor(red: 35/255, green: 82/255, blue: 126/255, alpha: 1)
        self.tabVw.backgroundColor = UIColor(red: 35/255, green: 82/255, blue: 126/255, alpha: 1)
        pazienteBtn.setTitle("PAZIENTI", for: .normal)
        pazienteBtn.titleLabel?.font = UIFont.txtFontBold
        pazienteBtn.setTitleColor(.white, for: .normal)
        newPazienteBtn.setTitle("NUOVO PAZIENTE", for: .normal)
        newPazienteBtn.titleLabel?.font = UIFont.txtFontBold
        newPazienteBtn.setTitleColor(.white, for: .normal)
        
    }
    
    func subHeadingLblUI()
    {
        subHeadingLbl.text = "Benvenuto!\nMettiti in CONTATTO \ncon i tuoi PAZIENTI"
        subHeadingLbl.textColor = UIColor.docThemeColor
        subHeadingLbl.font = UIFont.appTitle2
        
    }
    
    func btnLblUI()
    {
        btnLbl.text = "NUOVO PAZIENTE"
        btnLbl.textColor = UIColor.headingColor
        btnLbl.font = UIFont.btnFont
    }
    
    
    @IBAction func pazienteBtnActn(_ sender: Any) {
        if AppUtils.AppDelegate().docApproved == false {
            
            AppUtils.showToast(message:Constant.Msg.approvalPending)
            return
        }
        let vc = Constant.Controllers.docDashTab.get() as! DocDashTabBarViewController
        vc.whBtn = false
        self.navigationController?.pushViewController(vc, animated: true)
      //  self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func newPazienteActn(_ sender: Any) {
        
        if AppUtils.AppDelegate().docApproved == false {
            
            AppUtils.showToast(message:Constant.Msg.approvalPending)

            return
        }
        
        let vc = Constant.Controllers.docDashTab.get() as! DocDashTabBarViewController
        vc.whBtn = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

    @IBAction func btnActn(_ sender: UIButton) {
       let vc = Constant.Controllers.home1.get() as! Home1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    
        
    }
    

}
