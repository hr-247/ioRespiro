//
//  PatientRegistrationViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 07/12/2020.
//

import UIKit
import McPicker


class PatientRegistrationViewController: UIViewController ,PatientButtonDelegate{
 
    //variables
    var formData = FormModal()
    var patologyArr = [String]()
    
 
    @IBOutlet weak var patientRegisTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Registrazione", controller: Constant.Controllers.patientRegistration, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
      //  headingLblProperty()
        tableViewProperty()
        getPatologyFromServer()
   
    }


        func tableViewProperty()
        {
//            tableViewHeightCons.constant = 0.8*UIScreen.main.bounds.height
            patientRegisTableView.register(UINib(nibName: "PatientRegistrationTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientRegistrationTableViewCell")
            patientRegisTableView.delegate = self
            patientRegisTableView.dataSource = self
        }
    
    func termsBtnClckd() {
        openTnC()
    }
    
    func PatientRegisterBtnClicked() {
        
        self.view.endEditing(true)
        
        var passMatch = false
        var emptyFields = false
        var emailStr = String()
        var uname = String()
        
        if let nm = self.formData.name
        {
            uname = nm
        }
        
        if let em = self.formData.email
        {
            emailStr = em
        }
        
        let name = isValidUsrName(testStr: uname)
        let email = isValidEmail(testStr: emailStr)
     
        if formData.password == formData.confirmPassword
        {
            passMatch = true
        }else{
            AppUtils.showToast(message: Constant.Msg.passwordNotMatch)
            return
        }
        
        if self.formData.name == "" ||  self.formData.email == ""{
                   
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
            
        }else{
            emptyFields = true
        }
        
        if name == true && email == true && passMatch == true && emptyFields == true  {
           registerAPI()
                   
                   
               }
     
       
    }
    
    func SendPatientFormData(data: FormModal) {
        self.formData = data
    }

    }
    extension PatientRegistrationViewController : UITableViewDataSource, UITableViewDelegate
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatientRegistrationTableViewCell", for: indexPath) as! PatientRegistrationTableViewCell
            cell.delegate = self
            cell.nameTextField.delegate = self
            cell.emailTextField.delegate = self
            cell.patologieTextField.delegate = self
            cell.passwordTextField.delegate = self
            cell.reEnterPassword.delegate = self
            cell.patologieTextField.text = self.formData.patology

            return cell
        }
        
        
    }

extension PatientRegistrationViewController
{
   
    func pickerClicked()
{
        
        self.view.endEditing(true);
        let data: [[String]] = [self.patologyArr]
        let mcPicker = McPicker(data: data)
        mcPicker.label?.font = UIFont.lightFont
        mcPicker.toolbarButtonsColor = UIColor.patientThemeColor
        mcPicker.toolbarBarTintColor = .lightGray
        mcPicker.backgroundColor = .lightGray
        
        //mcPicker.backgroundColorAlpha = 0.50
        mcPicker.pickerBackgroundColor = .lightGray

        
        mcPicker.show(doneHandler: { [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                self?.formData.patology = name
                self?.patientRegisTableView.reloadData()
            }

            }, cancelHandler: {
                print("Canceled Styled Picker")
            }, selectionChangedHandler: { (selections: [Int:String], componentThatChanged: Int) -> Void  in
                let newSelection = selections[componentThatChanged] ?? "Failed to get new selection!"
                print("Component \(componentThatChanged) changed value to \(newSelection)")
            })
        

        
    }
    
    
    func registerAPI()
    {
        
        guard let email = formData.email, let name = formData.name, let password = formData.password, let patologie = formData.patology
        else {return}
        Utils.startLoadingWithTitle("Registering...")
        let post = "name=\(name)&email=\(email)&password=\(password)&password_confirmation=\(password)&patologie=\(patologie)&type=PATIENT"
        Service.sharedInstance.postRequest(Url: APIManager.APIs.register, modalName: RegisterModal.self, parameter: post) { (modal, error) in
            Utils.stopLoading()

            if error != nil
            {
                AppUtils.showToast(message: Constant.Msg.invalidRegister)
                return
            }
            
            
            AppUtils.showToast(message: Constant.Msg.regCompleteMsg)
            
            guard let error = modal?.errors else {
                let vc = Constant.Controllers.patientLogin.get() as! PatientLoginViewController
                self.navigationController?.pushViewController(vc, animated: true)
                self.removeLastFromNavigationStack()

                return}
            
           
            
        }
        
        
    }
    
    func getPatologyFromServer()
    {
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Patology, modalName: PatologyModal.self) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil{
                
                if let arr = modal?.results
                {
                    for data in arr{
                        if let patology = data.pathology_name
                        {
                            self.patologyArr.append(patology)
                        }
                    }
                }
                
            }
        }
        
    }
    
    
}



