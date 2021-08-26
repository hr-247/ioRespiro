//
//  DocLoginViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 09/12/2020.
//

import UIKit

class DocLoginViewController: UIViewController {
    
    
    //outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtnLbl: UILabel!
    @IBOutlet weak var forgotPass: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtnProperty()
        textFieldProperty()
        addBackButton()
        forgetPassBtnUI()
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
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Email",                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.docThemeColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.docThemeColor])
        passwordTextField.isSecureTextEntry = true
        
        usernameTextField.font = UIFont.lightFont
        passwordTextField.font = UIFont.lightFont
        
    }
    
    func forgetPassBtnUI()
    {
        forgotPass.setTitle("password dimenticata", for: .normal)
        forgotPass.titleLabel?.font =  UIFont.textFont
        forgotPass.setTitleColor(UIColor.docThemeColor, for: .normal)
        
    }
    
    @IBAction func ForgetPassActn(_ sender: UIButton) {
        
        let vc = Constant.Controllers.forgetPass.get() as! ForgetPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @IBAction func loginBtnActn(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        
        guard let nm = usernameTextField.text
        else{
         
         return
        }
        
        let name = isValidEmail(testStr: nm)
        
        if name == true && passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            
           loginAPI()
            
        }
        else if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        else if name == false {
            
            AppUtils.showToast(message: Constant.Msg.invalEmailMsg)
            return
        }
    }
    

}


extension DocLoginViewController
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
            
                if type != ClassConstants.UserType.doctor {
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
                }
                else if status == "1"
                {
                    AppUtils.AppDelegate().docApproved = false
                    self.moveToLandingPage()
                    AppUtils.showToast(message: Constant.Msg.approvalPending)
                    Utils.saveStringForKey(key: ClassConstants.Datakeys.email, value: email)
                    Utils.saveStringForKey(key: ClassConstants.Datakeys.type, value: type)
                    if let token = modal?.token
                    {
                       // self.getUser(token: token)
                        Utils.saveStringForKey(key: ClassConstants.Datakeys.token, value: token)
                    }
                    if let id = modal?.userid
                    {
                        Utils.saveStringForKey(key: ClassConstants.Datakeys.userId, value: String(describing: id))
                    }
                    
                    
                    
                }
                else if status == "2"
                {
                    AppUtils.showToast(message: Constant.Msg.loginSuccess)

                    AppUtils.AppDelegate().docApproved = true
                    
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
                    
                    if let linkStatus = modal?.linked
                    {
                        if linkStatus == false
                        {
                            self.moveToLandingPage()
                        }else{
                            self.moveToListinggPage()
                        }
                    }
                    
                    if let fcm = Utils.getStringForKey(ClassConstants.Datakeys.fcmToken)
                    {
                        let fcm64 = fcm.toBase64()
                        self.firbaseTokenApi(fcmtoken : fcm64)
                    }
                    
                }
            
      
            
        }
        
        
    }
    
    func getUser(token : String)
    {
        Service.sharedInstance.getUserProfile(Url: APIManager.APIs.get_Profile, token: token , modalName: UserModal.self) { (modal, error) in
            Utils.stopLoading()
            if let type = modal?.type
            {
                if type == ClassConstants.UserType.doctor {
                    Utils.saveStringForKey(key: ClassConstants.Datakeys.token, value: token)
                    Utils.saveStringForKey(key: ClassConstants.Datakeys.type, value: type)
                    
                    if let fcm = Utils.getStringForKey(ClassConstants.Datakeys.fcmToken)
                    {
                        let fcm64 = fcm.toBase64()
                        self.firbaseTokenApi(fcmtoken : fcm64)
                    }
                    
                    AppUtils.showToast(message: Constant.Msg.loginSuccess)
                    let vc = Constant.Controllers.home3.get() as! Home3ViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    return
                }
                
            }
            
                AppUtils.showToast(message: Constant.Msg.invalidCredentials)
            
            
        }
    }
    
    
  
    
    
    func moveToLandingPage()
    {
        let vc = Constant.Controllers.home3.get() as! Home3ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func moveToListinggPage()
    {
        let vc =  Constant.Controllers.docDashTab.get() as! DocDashTabBarViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
    
    //insert firebase token API
    func firbaseTokenApi(fcmtoken : String)
    {
      
        let post = "name=fcm&attributes[token]=\(fcmtoken)"
        Service.sharedInstance.postRequest(Url: APIManager.APIs.firebase_Token, modalName: SubmitTest.self, parameter: post) { (modal, error) in

          
    }
}
    
    
}
