//
//  PatientLoginViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 07/12/2020.
//

import UIKit

class PatientLoginViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var loginBtnLbl: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPass: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
      //  self.view.backgroundColor = UIColor.statusBarColor
        loginBtnProperty()
        textFieldProperty()
        forgetPassBtnUI()
        addBackButton()
        if #available(iOS 14.0, *) {
                self.usernameTextField.borderStyle = .line
               
            self.passwordTextField.borderStyle = .line

              }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent
            {
                print("View controller was popped")
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
            else
            {
                print("New view controller was pushed")
            }
        
       //
    }
    
    func loginBtnProperty()
    {
        loginBtnLbl.text = "LOGIN"
        loginBtnLbl.font = UIFont.btnFont
        loginBtnLbl.textColor = UIColor.headingColor
    }
    
    func textFieldProperty()
    {
        usernameTextField.setLeftPaddingPoints(Constant.leftPaddingPointsVal)
        passwordTextField.setLeftPaddingPoints(Constant.leftPaddingPointsVal)
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Email",                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.patientThemeColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.patientThemeColor])
        passwordTextField.isSecureTextEntry = true
        
        usernameTextField.font = UIFont.lightFont
        passwordTextField.font = UIFont.lightFont
    }
    
    func forgetPassBtnUI()
    {
        forgotPass.setTitle("password dimenticata", for: .normal)
        forgotPass.titleLabel?.font =  UIFont.textFont
        forgotPass.setTitleColor(UIColor.patientThemeColor, for: .normal)
        
    }
    
    @IBAction func ForgetPassActn(_ sender: UIButton) {
        
        let vc = Constant.Controllers.patientForgetPass.get() as! PatientForgetPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func loginBtnActn(_ sender: UIButton) {
        self.view.endEditing(true)
        
        
        guard let em = usernameTextField.text
        else{
            return
        }
       
        let email = isValidEmail(testStr:em)
        
        if email == true && passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            
            self.loginAPI()
     
        }
        else if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        else if email == false {
            
            AppUtils.showToast(message: Constant.Msg.invalEmailMsg)
            return
        }
        
        
    }
}


extension PatientLoginViewController
{
    
    func loginAPI()
    {
        
        guard let email = self.usernameTextField.text, let password = self.passwordTextField.text  else {return}
        Utils.startLoadingWithTitle("Authenticating...")
        let post = "email=\(email)&password=\(password)"
        Service.sharedInstance.postRequest(Url: APIManager.APIs.login, modalName: LoginModal.self, parameter: post) { (modal, error) in

            Utils.stopLoading()
            guard let loginStatus = modal?.login_status else {
                AppUtils.showToast(message: Constant.Msg.errorMsg)

                return
            }
            
                if loginStatus == "0"{
                AppUtils.showToast(message: Constant.Msg.invalidCredentials)
                    return
                }
            
            
            guard let type = modal?.usertype else {
                AppUtils.showToast(message: Constant.Msg.errorMsg)
                return
            }
            
                if type != ClassConstants.UserType.patient {
                    AppUtils.showToast(message: Constant.Msg.invalidCredentials)

                    return
                }
            
            guard let status = modal?.status else {
                AppUtils.showToast(message: Constant.Msg.errorMsg)
                return
            }
            
            if status == "0"
            {
                AppUtils.showToast(message: Constant.Msg.emailVerificationPending)
                return
            }else
            {
                AppUtils.showToast(message: Constant.Msg.loginSuccess)

                
                if let token = modal?.token
                {
                   // self.getUser(token: token)
                    Utils.saveStringForKey(key: ClassConstants.Datakeys.token, value: token)
                }
                if let id = modal?.userid
                {
                    Utils.saveStringForKey(key: ClassConstants.Datakeys.userId, value: String(describing: id))
                }
                Utils.saveStringForKey(key: ClassConstants.Datakeys.email, value: email)
                Utils.saveStringForKey(key: ClassConstants.Datakeys.type, value: type)
                
                
                if let fcm = Utils.getStringForKey(ClassConstants.Datakeys.fcmToken)
                {
                    let fcm64 = fcm.toBase64()
                    self.firbaseTokenApi(fcmtoken : fcm64)
                }
                let vc = Constant.Controllers.patientDashboard.get() as! PatientDashboardViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        
  }
        
    }
    
    func getUser(token : String)
    {
        Service.sharedInstance.getUserProfile(Url: APIManager.APIs.get_Profile, token: token , modalName: UserModal.self) { (modal, error) in
            Utils.stopLoading()
            
            if let type = modal?.type
            {
                if type == ClassConstants.UserType.patient {
                    Utils.saveStringForKey(key: ClassConstants.Datakeys.token, value: token)
                    Utils.saveStringForKey(key: ClassConstants.Datakeys.type, value: type)
                    if let fcm = Utils.getStringForKey(ClassConstants.Datakeys.fcmToken)
                    {
                        let fcm64 = fcm.toBase64()
                        self.firbaseTokenApi(fcmtoken : fcm64)
                    }
                    AppUtils.showToast(message: Constant.Msg.loginSuccess)
                    let vc = Constant.Controllers.patientDashboard.get() as! PatientDashboardViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    return
                }
                
                
            }
            
                AppUtils.showToast(message: Constant.Msg.invalidCredentials)
            
            
            
        }
        

        
    }
    
    //insert firebase token API
    func firbaseTokenApi(fcmtoken : String)
    {
      
        Utils.startLoadingWithTitle("")
        let post = "name=fcm&attributes[token]=\(fcmtoken)"
        Service.sharedInstance.postRequest(Url: APIManager.APIs.firebase_Token, modalName: SubmitTest.self, parameter: post) { (modal, error) in
            Utils.stopLoading()

          
    }
}
    
    
    
}
