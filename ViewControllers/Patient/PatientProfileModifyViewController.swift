//
//  PatientProfileModifyViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 21/12/2020.
//

import UIKit
import McPicker
import DatePickerDialog

class PatientProfileModifyViewController: UIViewController {
    
    //variables
    var dscData : UserModal?
    var resp : String?
   // var formData = FormModal()
    
    //outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonNavigationBar(title: "Profilo", controller: Constant.Controllers.pProfileModify, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        tableViewProperty()
        headingUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let token = Utils.getStringForKey(ClassConstants.Datakeys.token)
        {
        getUser(token : token)
        }
    }
    
    func headingUI()
    {
        
        btnLbl.text = "CONFERMA"
        btnLbl.font = UIFont.btnFont
        btnLbl.textColor = UIColor.headingColor
        
    }
    
    func tableViewProperty()
    {
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.layer.cornerRadius = 20
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func updateBtnACtn(_ sender: UIButton) {
        
        self.view.endEditing(true)
        profileUpdateApi()
        
    }
    
    
}
extension PatientProfileModifyViewController  : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return ClassConstants.patientHeadingArr.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        cell.headingLbl.text = ClassConstants.patientHeadingArr[indexPath.row]
        cell.labelUI(color: UIColor.patientThemeColor)
        cell.dscTF.isHidden = false
        cell.segment.isHidden = true
        cell.dscTF.isUserInteractionEnabled = true
        cell.dscTF.delegate = self
        
        if indexPath.row == 0
        {
            cell.dscTF.tag = 301
            cell.dscTF.text = dscData?.name
        }
        else if indexPath.row == 1
        {
           // cell.dscTF.tag = 303
            cell.dscTF.isUserInteractionEnabled = false
            cell.dscTF.text = dscData?.email
        }
        else if indexPath.row == 2
        {
           // cell.dscTF.tag = 304
            cell.dscTF.isUserInteractionEnabled = false
            cell.dscTF.text = dscData?.patient_profile?.date_of_birth ?? ""
        }
        
        else if indexPath.row == 3
        {
            cell.dscTF.isHidden = true
            cell.segment.isHidden = false
            cell.segmentActn(titles: ClassConstants.sessoArr)
            cell.segment.tag = 3
            cell.segment.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
            cell.segment.selectedSegmentIndex = ClassConstants.sessoArr.firstIndex(of: dscData?.patient_profile?.sex ?? "") ?? 0
        }
        
        else if indexPath.row == 4
        {
            cell.segment.tag = 4
            cell.segmentActn(titles: ClassConstants.patArr)
            cell.dscTF.isHidden = true
            cell.segment.isHidden = false
            cell.segment.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
            cell.segment.selectedSegmentIndex = ClassConstants.patArr.firstIndex(of: dscData?.patient_profile?.patologie_respiratorie ?? "") ?? 0
            
        }
        if indexPath.row == 5
        {
            cell.dscTF.tag = 305
            
            if let res = self.resp
            {
                cell.dscTF.text = res

            }
            
//            let array = dscData?.patient_profile?.altre_respiratorie
//            cell.dscTF.text = array?.joined(separator: ",") ?? ""
        }
        if indexPath.row == 6
        {
            cell.dscTF.tag = 306
            cell.dscTF.text = dscData?.patient_profile?.note ?? ""
        }
        if indexPath.row == 7
        {
            
            cell.dscTF.isUserInteractionEnabled = false
            cell.dscTF.text = dscData?.patient_profile?.patient_code
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2
        {
            datePickerTapped()
        }
//        else if indexPath.row == 4
//        {
//            pickerClicked()
//        }
        
    }
    
    
}
extension PatientProfileModifyViewController
{
    
    func pickerClicked()
    {
        
        self.view.endEditing(true);
        let data: [[String]] = [["Patologie 1", "Patologie 2", "Patologie 3", "Patologie 4", "Patologie 5", "Patologie 6"]]
        let mcPicker = McPicker(data: data)
        mcPicker.label?.font = UIFont.lightFont
        mcPicker.toolbarButtonsColor = UIColor.patientThemeColor
        mcPicker.toolbarBarTintColor = .lightGray
        mcPicker.backgroundColor = .lightGray
        mcPicker.pickerBackgroundColor = .lightGray
        
        
        mcPicker.show(doneHandler: { [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                
                self?.dscData?.patient_profile?.patologie = name
                
            }
            
        }, cancelHandler: {
            print("Canceled Styled Picker")
        }, selectionChangedHandler: { (selections: [Int:String], componentThatChanged: Int) -> Void  in
            let newSelection = selections[componentThatChanged] ?? "Failed to get new selection!"
            print("Component \(componentThatChanged) changed value to \(newSelection)")
        })
        
        
        
    }
    
    @objc func segmentSelected(sender: UISegmentedControl) {
        
        if sender.tag == 3
        {
        if sender.selectedSegmentIndex == 0 {
            dscData?.patient_profile?.sex = sender.titleForSegment(at: 0)
        }
        if sender.selectedSegmentIndex == 1 {
            dscData?.patient_profile?.sex = sender.titleForSegment(at: 1)
        }
        }else{
            if sender.selectedSegmentIndex == 0 {
                dscData?.patient_profile?.patologie_respiratorie = sender.titleForSegment(at: 0)
            }
            if sender.selectedSegmentIndex == 1 {
                dscData?.patient_profile?.patologie_respiratorie = sender.titleForSegment(at: 1)
            }
            if sender.selectedSegmentIndex == 2 {
                dscData?.patient_profile?.patologie_respiratorie = sender.titleForSegment(at: 2)
            }
            
        }
    }
    
    
    func profileUpdateApi()
    {
        guard let email = self.dscData?.email, let patologie = self.dscData?.patient_profile?.patologie , let dob = self.dscData?.patient_profile?.date_of_birth, let sex = self.dscData?.patient_profile?.sex, let pato_respiratorie = self.dscData?.patient_profile?.patologie_respiratorie, var altre_respiratorie = self.resp?.components(separatedBy: ","), let note = self.dscData?.patient_profile?.note, let name = self.dscData?.name
        
        else {return}
        Utils.startLoadingWithTitle("")
        
        
        altre_respiratorie.removeAll { (str) -> Bool in
            return str.isEmpty
        }
        
        var index = 0
             
             var postParameters = ""
        
            // let array  = altre_respiratorie.components(separatedBy: ", ")
        
             for item in altre_respiratorie{
                 postParameters += "&altre_respiratorie[\(index)]=\(item)"
                 index = index + 1
             }
             print(postParameters)

        
        
        let patch = "name=\(name)&email=\(email)&patologie=\(patologie)&location=\("location")&date_of_birth=\(dob)&sex=\(sex)&patologie_respiratorie=\(pato_respiratorie)\(postParameters)&note=\(note)"
        Service.sharedInstance.patchRequest(Url: APIManager.APIs.update_Profile, modalName: SubmitTest.self, parameter: patch) { (modal, error) in
            Utils.stopLoading()
            
            if error == nil{
                self.navigationController?.popViewController(animated: true)
                
            }
            AppUtils.showToast(message: modal?.message! ?? "")
            
        }
        
    }
    
    func datePickerTapped() {
        DatePickerDialog().show("DATA", doneButtonTitle: "FATTO", cancelButtonTitle: "INDIETRO",maximumDate: Date(), datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.dscData?.patient_profile?.date_of_birth = formatter.string(from: dt)
                self.tableView.reloadData()
            }
        }
    }
    
}
    
    extension PatientProfileModifyViewController
    {
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            
            if textField.tag == 301
            {
                self.dscData?.name = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }
           
            if textField.tag == 303
            {
                self.dscData?.email = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if textField.tag == 305
            {
                
                self.resp = textField.text
            }
            if textField.tag == 306
            {
                self.dscData?.patient_profile?.note = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }
           
            
        }
        override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
        }
        
        func getUser(token : String)
        {
            Utils.startLoadingWithTitle("")
            let url = APIManager.APIs.get_Profile
            Service.sharedInstance.getUserProfile(Url: url, token: token , modalName: UserModal.self) { (modal, error) in
                Utils.stopLoading()
                
                guard let data =  modal
                else  {
                    AppUtils.showToast(message: Constant.Msg.errorMsg)
                    return
                }
                
                if let profile = modal?.patient_profile
                {
                    self.resp = Utils.handleMultiple(modal: profile)
                }
                self.dscData = data
                self.tableView.reloadData()
                    
                }
                
              
            }
        
        
    }

