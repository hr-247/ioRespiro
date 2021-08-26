//
//  AssegnaTestViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 20/01/2021.
//

import UIKit
import McPicker
import DatePickerDialog


struct quesModal {
    var question_id : Int?
    var choices : [Int]?
    
    init(queId : Int?, choice : [Int]? ) {
        question_id = queId
        choices = choice
    }
}



class AssegnaTestViewController: UIViewController {
    
    //variables
    var batchNo = ""
    var timeStamp = ""
    var quesArr = [quesModal]()
    var testArr = ["TEST TAI", "TEST CAT"]
    var repititionArr = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var freqArr = [String]()
    var modalArray = [FrequencyListModal]()
    var selectedFreq = 0
    
    
    //outlets
    @IBOutlet weak var testTF: UITextField!
    @IBOutlet weak var dateInitTF: UITextField!
    @IBOutlet weak var repetitionTF: UITextField!
    @IBOutlet weak var frequencyTF: UITextField!
    @IBOutlet weak var btnLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var dropDwnImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonNavigationBar(title: "Assegna Test", controller: Constant.Controllers.assegnaTest, color: UIColor.docThemeColor, shadowColor: UIColor.docShadowColor, icon: "home", badgeCount: "")
        dropDwnImg.image = UIImage(named: "dropDownImg")
        headingLblUI()
        TextFieldUI()
        btnLblUI()
        testTF.delegate = self
        dateInitTF.delegate = self
        repetitionTF.delegate = self
        frequencyTF.delegate = self
        getFrequencyFromServer()
        
        let ques = quesModal(queId: 1, choice: [1,2])
        
        quesArr.append(ques)
        
    }
    
    func headingLblUI()
    {
        headingLbl.text = batchNo
        headingLbl.font = UIFont(name: AppFontName.ralewayBold, size: 20)
        headingLbl.textColor = UIColor.docThemeColor
    }
    
    func TextFieldUI()
    {
        testTF.setBorderAndColor(textField: testTF, placeholderTxt: "Test", txtClr: UIColor.docThemeColor, font: UIFont.txtFontBold, brdrClr: UIColor.docThemeColor)
        dateInitTF.setBorderAndColor(textField: dateInitTF, placeholderTxt: "Data inizio", txtClr: UIColor.docThemeColor, font: UIFont.txtFontBold, brdrClr: UIColor.docThemeColor)
        repetitionTF.setBorderAndColor(textField: repetitionTF, placeholderTxt: "Ripetizioni", txtClr: UIColor.docThemeColor, font: UIFont.txtFontBold, brdrClr: UIColor.docThemeColor)
        frequencyTF.setBorderAndColor(textField: frequencyTF, placeholderTxt: "Frequenza", txtClr: UIColor.docThemeColor, font: UIFont.txtFontBold, brdrClr: UIColor.docThemeColor)
    }
    
    
    func btnLblUI()
    {
        btnLbl.text = "CONFERMA"
        btnLbl.font = UIFont.btnFont
        btnLbl.textColor = UIColor.headingColor
    }
    func alert(){
        
        let alertController = UIAlertController(title: "", message: "Test assegnati correttamente!", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.sendToNxt()
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func sendToNxt()
    {
//        let vc = Constant.Controllers.assignatiTest.get() as! AssignatiTestViewController
//        vc.batchNo = self.batchNo
//        self.navigationController?.pushViewController(vc, animated: true)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func assegnaActn(_ sender: Any) {
        
        if let patientCode = Utils.getStringForKey(ClassConstants.Datakeys.patientCode)
        {
            assignTestApi(code: patientCode)
        }
        
    }
    
    
    
}

extension AssegnaTestViewController
{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.testTF {
            self.testTF.text = ""
            pickerClicked(data: testArr, txtFieldType: "testTF")
            return false
        }
        else if textField == self.dateInitTF
        {
            datePickerTapped()
            return false
            
        }
        else if textField == self.repetitionTF {
            
            pickerClicked(data: repititionArr, txtFieldType: "repetitionTF")
            return false
        }
        else if textField == self.frequencyTF {
            
            
            pickerClicked(data: freqArr, txtFieldType: "frequencyTF")
            
            return false
        }
        return true
    }
    
    
    
    
    
    func pickerClicked(data: [String], txtFieldType: String)
    {
        
        self.view.endEditing(true);
        let data: [[String]] = [data]
        let mcPicker = McPicker(data: data)
        mcPicker.label?.font = UIFont.txtFontBold
        mcPicker.label?.textColor = UIColor.docThemeColor
        mcPicker.toolbarButtonsColor = UIColor.docThemeColor
        
        mcPicker.toolbarBarTintColor = .white
        mcPicker.backgroundColor = .lightGray
        //mcPicker.backgroundColorAlpha = 0.50
        mcPicker.pickerBackgroundColor = .white
        
        
        mcPicker.show(doneHandler: { [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                if txtFieldType == "testTF"{
                    self?.testTF.text = name
                }else if txtFieldType == "repetitionTF"{
                    self?.repetitionTF.text = name
                    if name == "1" {
                        self?.selectedFreq = 1
                        self?.frequencyTF.text = ""
                        self?.frequencyTF.isUserInteractionEnabled = false
                        self?.frequencyTF.alpha = 0.6
                    }else
                    {
                        self?.frequencyTF.isUserInteractionEnabled = true
                        self?.frequencyTF.alpha = 1.0
                    }
                    
                    
                }else{
                    let index = self?.freqArr.firstIndex(of: name)
                    self?.selectedFreq = (self?.modalArray[index!].id)!
                    self?.frequencyTF.text = name
                }
                self?.dropDwnImg.image = UIImage(named: "dropRght")
                
            }
            
        }, cancelHandler: {
            print("Canceled Styled Picker")
        }, selectionChangedHandler: { (selections: [Int:String], componentThatChanged: Int) -> Void  in
            let newSelection = selections[componentThatChanged] ?? "Failed to get new selection!"
            print("Component \(componentThatChanged) changed value to \(newSelection)")
        })
        
        
        
    }
    
    
    func datePickerTapped() {
        self.view.endEditing(true);
        DatePickerDialog().show("Data", doneButtonTitle: "FATTO", cancelButtonTitle: "INDIETRO", datePickerMode: .date) { [self] date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, yyyy"
                self.dateInitTF.text = formatter.string(from: dt)
                self.timeStamp = dt.timeStamp
                
            }
        }
    }
    
    
    
    //Mark:- POST APi to assign test
    func assignTestApi(code: String)
    {
        
        
        guard let repetition = self.repetitionTF.text, let type = self.testTF.text, let drId = Utils.getStringForKey(ClassConstants.Datakeys.userId)
        else{
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        
        if self.selectedFreq == 0 {
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        
        if type == ""{
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        
        
        var testType = ""
        
        if type == "TEST TAI"
        {
            testType = "TAI"
        }else if type == "TEST CAT"{
            testType = "CAT"
        }
        
        
        Utils.startLoadingWithTitle("")
        
        let post : [String : Any] = ["repetitions": repetition,
                                     "start_date": timeStamp,
                                     "frequency": self.selectedFreq,
                                     "batch_number": "",
                                     "type": testType,
                                     "doctor_id": drId,
                                     "patient_id": AppUtils.AppDelegate().patientId]
        
        Service.sharedInstance.postJSONRequest(Url: APIManager.APIs.assign_New_Test, modalName: SubmitTest.self, parameter: post) { (modal, error) in
            
            
            Utils.stopLoading()
            
            
            if error != nil{
                AppUtils.showToast(message: modal?.message! ?? "error")
                return
            }else{
                self.alert()

            }
            
            
            
        }
        
        
    }
    
    func getFrequencyFromServer()
    {
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Frequency, modalName: FrequencyModal.self) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil{
                
                if let arr = modal?.results
                {
                    self.modalArray = arr
                    for data in arr{
                        if let freq = data.Desc
                        {
                            self.freqArr.append(freq)
                        }
                    }
                }
                
            }
        }
        
    }
}
