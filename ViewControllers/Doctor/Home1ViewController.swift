//
//  Home1ViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 11/12/2020.
//

import UIKit

class Home1ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var topHeaderCons: NSLayoutConstraint!
    @IBOutlet weak var patientLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var confirmLbl: UILabel!
    @IBOutlet weak var cancelLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonNavigationBar(title: "Nuovo Paziente", controller: Constant.Controllers.home1, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")

     //   headingLblUI()
        patientLblUI()
        textFieldUI()
        btnLblUI()
    
        
    }
    
    func headingLblUI()
    {
        topHeaderCons.constant = 0.04*UIScreen.main.bounds.height;
        headingLbl.text = "Home"
        headingLbl.textColor = UIColor.headingColor
        headingLbl.font = UIFont.appTitle2
    }
    
    func patientLblUI(){
        patientLbl.text = "Codice paziente"
        patientLbl.textColor = UIColor.black
        patientLbl.font = UIFont.homeScreenFont
    }
    
    func textFieldUI(){
      //  textField.text = "XYZ23455"
        textField.textColor = UIColor.docShadowColor
        textField.font = UIFont.homeScreenTextFieldFont
        textField.setLeftPaddingPoints(20)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.docThemeColor.cgColor
        textField.layer.cornerRadius = 30
        
    }
    func btnLblUI(){
        confirmLbl.text = "CONFERMA"
        confirmLbl.textColor = UIColor.headingColor
        confirmLbl.font = UIFont.appHeadingBody
        
        cancelLbl.text = "ANNULLA"
        cancelLbl.textColor = UIColor.headingColor
        cancelLbl.font = UIFont.appHeadingBody
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true);
        print("view did appear");
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        
    }

    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {

        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer)
        {
            if (self.navigationController?.viewControllers.count ?? 0 > 1)
            {
                return true
            }

            return false
        }

        return true
    }
    
    
    @IBAction func confirmBtnActn(_ sender: Any) {
        self.view.endEditing(true)
        if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            AppUtils.showToast(message: Constant.Msg.codeMsg)
            return
        }
        else{
           
        if let code = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        {
        linkPatientApi(code: code)
        }
        }

            
            
   }

    

    @IBAction func cancelBtnActn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension Home1ViewController{
    
    func linkPatientApi(code: String)
    {
      
        Utils.startLoadingWithTitle("")
        let request = "patient_code=\(code)"
        Service.sharedInstance.postRequest(Url: APIManager.APIs.link_Patient, modalName: LinkPatient.self, parameter: request) { (modal, error) in
            Utils.stopLoading()
            
            if error != nil{
                AppUtils.showToast(message: Constant.Msg.errorMsg)
                return
            }
            
            if let status = modal?.status
            {
                AppUtils.showToast(message: modal?.message ?? "")
                if status == "1" {
                    self.tabBarController?.selectedIndex = 0
                    self.textField.text = ""
                    Utils.saveStringForKey(key: ClassConstants.Datakeys.patientCode, value: code)
                }
            }
           
            

    }
}
}

