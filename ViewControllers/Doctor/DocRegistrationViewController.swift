//
//  DocRegistrationViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 06/12/2020.
//

import UIKit
import SafariServices


class DocRegistrationViewController: UIViewController, buttonDelegate {
   
    
    //variables
    var formData = FormModal()
   
    //outlets
   // @IBOutlet weak var regisHeadingLbl: UILabel!
    @IBOutlet weak var registrationTV: UITableView!
   // @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Registrazione", controller: Constant.Controllers.docRegistration, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "bellIcon", badgeCount: "")
    //    headingLblProperty()
        tableViewProperty()
    //    addBackButton()

    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        <#code#>
//    }
    

    func tableViewProperty()
    {
        registrationTV.register(UINib(nibName: "DocRegistrationTableViewCell", bundle: nil), forCellReuseIdentifier: "DocRegistrationTableViewCell")
        registrationTV.delegate = self
        registrationTV.dataSource = self
    }
    
    func termsBtnClickd()
    {
        openTnC()

    }
    
    func sendFormData(data: FormModal) {
        self.formData = data
    }
    
    func RegisterBtnClicked() {
        
        self.view.endEditing(true)
        
        var passMatch = false
        var emptyFields = false
        
        
        guard let nm = self.formData.name
        else{
            return
        }
        
        guard let em = self.formData.email
        else{
            return
        }
        
        let name = isValidUsrName(testStr: nm)
        let email = isValidEmail(testStr: em)
     
        if formData.password == formData.confirmPassword
        {
            passMatch = true
        }else{
            AppUtils.showToast(message: Constant.Msg.passwordNotMatch)
            return
        }
        if self.formData.name == "" ||  self.formData.email == "" || self.formData.location == "" {
            
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        else if name == false {
            
            
            AppUtils.showToast(message: Constant.Msg.invalNmeMsg)
            return
        }
        else if email == false {
            
            AppUtils.showToast(message: Constant.Msg.invalEmailMsg)
            return
        }else if self.formData.tnCAccept == false {
            
            AppUtils.showToast(message: Constant.Msg.tncMsg)
            return
        }
        
        
        if formData.password == "" && formData.confirmPassword == ""{
            AppUtils.showToast(message: Constant.Msg.emptyFieldMsg)
            return
            
        }
        else{
            emptyFields = true
        }
        
        if name == true && email == true && passMatch == true && emptyFields == true  {
            
            registerAPI()
            
        }
   
           
       }

}
extension DocRegistrationViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocRegistrationTableViewCell", for: indexPath) as! DocRegistrationTableViewCell
        cell.delegate = self
        cell.nameTextField.delegate = self
        cell.emailTextField.delegate = self
        cell.locationTextField.delegate = self
        cell.passwordTextField.delegate = self
        cell.reEnterPassTextField.delegate = self

        return cell
    }
    
}

extension DocRegistrationViewController
{
    
    func registerAPI()
    {
        
        guard let email = formData.email, let name = formData.name, let password = formData.password, let location = formData.location
        else {return}
        Utils.startLoadingWithTitle("Registering...")
        let post = "name=\(name)&email=\(email)&password=\(password)&password_confirmation=\(password)&location=\(location)&type=DOCTOR"
        Service.sharedInstance.postRequest(Url: APIManager.APIs.register, modalName: RegisterModal.self, parameter: post) { (modal, error) in
            Utils.stopLoading()

            if error != nil
            {
                AppUtils.showToast(message: Constant.Msg.invalidRegister)
                return
            }
            
            AppUtils.showToast(message: Constant.Msg.regCompleteMsg)
            
            guard let error = modal?.errors else {
                let vc = Constant.Controllers.docLogin.get() as! DocLoginViewController
                self.navigationController?.pushViewController(vc, animated: true)
                self.removeLastFromNavigationStack()
                
                return}
            
        }
        
        
    }
    
}
