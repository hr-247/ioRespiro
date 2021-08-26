//
//  ForgetPasswordViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 28/12/2020.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var btnLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        BtnProperty()
        emailTFUI()
        addBackButton()
        if #available(iOS 14.0, *) {
                self.emailTextField.borderStyle = .line

              }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
  
    func BtnProperty()
    {
        btnLbl.text = "CONFERMA"
        btnLbl.font = UIFont.btnFont
        btnLbl.textColor = UIColor.headingColor
    }
    
    func emailTFUI()
    {
        emailTextField.setLeftPaddingPoints(Constant.leftPaddingPointsVal)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.docThemeColor])
        emailTextField.font = UIFont.lightFont
    }
    
    @IBAction func btnActn(_ sender: UIButton) {
        
        var emails = ""
        
        if let em = emailTextField.text
        {
            emails = em
        }
        
        let email = isValidEmail(testStr: emails)
        
        if email == true && emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            
            forgetPasswordAPI()
            
        }
        else if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        else if email == false {
            
            AppUtils.showToast(message: Constant.Msg.invalEmailMsg)
            return
        }
        
        
    }
        
        
        
        
    }

extension ForgetPasswordViewController
{
    
    func forgetPasswordAPI()
    {
        
        guard let email = self.emailTextField.text  else {return}
        Utils.startLoadingWithTitle("")
        let post = "email=\(email)"
        Service.sharedInstance.postRequest(Url: APIManager.APIs.forgot_Password, modalName: RegisterModal.self, parameter: post) { (modal, error) in

                Utils.stopLoading()
            self.navigationController?.popViewController(animated: true)
            if let msg = modal?.message
            {
                AppUtils.showToast(message: msg)

            }

        }
        
    }
}
    
    


