//
//  AddStatoSaluteViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 16/12/2020.
//

import UIKit
import McPicker

class AddStatoSaluteViewController: UIViewController {
    
    //variables
    var placeholderArr = ["Inserisci Nota...","Frequenza","Ripetizioni al giorno","Durata"]
    var repetitionArr = ["1","2","3","4","5","6","7","8","9","10"]
    var batchNumber = ""
    var healthListArr = [HealthTestModal]()
    var listArr = [String]()
    var frequency = ""
    var repetition : String? = ""
    var healthActivity = ""
    var selectedHealthIndex = 0
    var freqArr = [String]()
    var modalArray = [FrequencyListModal]()
    var selectedFreq = 0
    var duration : String? = ""
    
    
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var btnLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: "STATO SALUTE", controller: Constant.Controllers.addStato, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        tableViewProperty()
        btnLblUI()
        headingUI()
        getDataFrServer()
        getFrequencyFromServer()
    }
    
    func headingUI(){
      //  topHeadingCons.constant = 0.04*UIScreen.main.bounds.height
        headingLbl.text = batchNumber
        headingLbl.textColor = UIColor.docThemeColor
        headingLbl.font = UIFont(name: AppFontName.ralewayBold, size: 20)
        
    }
    
    func tableViewProperty(){
        tableView.register(UINib(nibName: "StatoSaluteTableViewCell", bundle: nil), forCellReuseIdentifier: "StatoSaluteTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func btnLblUI(){
       
        btnLbl.text = "CONFERMA"
        btnLbl.textColor = UIColor.headingColor
        btnLbl.font = UIFont.btnFont
        
    }
    
    func alert(){
        
        let alertController = UIAlertController(title: "", message: "Parametro assegnato correttamente!", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.sendToNext()
            
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func sendToNext(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    

    @IBAction func btnActn(_ sender: UIButton) {
        
        addHealthReport()
    }
    

}

extension AddStatoSaluteViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholderArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatoSaluteTableViewCell", for: indexPath) as! StatoSaluteTableViewCell
        cell.rightLbl.isHidden = true
        cell.textField.makeCorner(withRadius: 15)
        
        cell.textFieldUI(color: .docShadowColor, placeholderTxt: placeholderArr[indexPath.row], border: .docShadowColor)
        cell.cellNo = indexPath.row
        if indexPath.row == 0{
            cell.textField.text = self.healthActivity
            cell.textField.textColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 1)
        }
        
        else if indexPath.row == 1{
            if self.frequency == ""{
                cell.rightLbl.isHidden = true
            }else{
                cell.rightLbl.isHidden = false
                cell.rightLblUI(color: .docShadowColor, txt: self.frequency)
                let color = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 1)
                cell.textFieldUI(color: color, placeholderTxt: placeholderArr[indexPath.row], border: .docShadowColor)
            }
            
        }
        else if indexPath.row == 3{
            if self.duration == ""{
                cell.rightLbl.isHidden = true
            }else{
                cell.rightLbl.isHidden = false
                cell.rightLblUI(color: .docShadowColor, txt: self.duration ?? "")
                let color = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 1)
                cell.textFieldUI(color: color, placeholderTxt: placeholderArr[indexPath.row], border: .docShadowColor)
            }
        }
        
        else{
           
            if  self.repetition == ""{
                cell.rightLbl.isHidden = true
            }else{
                cell.rightLbl.isHidden = false
                cell.rightLblUI(color: .docShadowColor, txt: self.repetition ?? "")
                let color = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 1)
                cell.textFieldUI(color: color, placeholderTxt: placeholderArr[indexPath.row], border: .docShadowColor)
            }
        }
       
        cell.delegate = self
        
        return cell
    }
    
    
}

extension AddStatoSaluteViewController : StatoSaluteTableViewCellDelegate{
    func textFieldClicked(cellNo: Int ) {
        
        if cellNo == 1{
            pickerClicked(data: self.freqArr,whCell: cellNo)
        }else if cellNo == 2{
            pickerClicked(data: self.repetitionArr,whCell: cellNo)
        }else if cellNo == 3{
            pickerClicked(data: ClassConstants.DaysArr,whCell: cellNo)
        }
        else{
            
            for data in self.healthListArr
            {
                if let list = data.name{
                    self.listArr.append(list)
                }
            }
            
            
            pickerClicked(data: self.listArr,whCell: cellNo)
        
            
            
        }
        
    }
    
    
}

extension AddStatoSaluteViewController{
    
    //MARK: POST API
    func addHealthReport(){
       
        
        guard let drId = Utils.getStringForKey(ClassConstants.Datakeys.userId),let repetition = self.repetition,let dur = self.duration
        else{
            
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        
        if self.selectedHealthIndex == 0 {
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        
        if self.selectedFreq == 0 {
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        Utils.startLoadingWithTitle("")
        let request : [String:Any] = ["doctor_id": drId,
                                      "patient_id": AppUtils.AppDelegate().patientId,
                                      "testId": self.selectedHealthIndex,
                                      "frequencyId": self.selectedFreq,
                                      "repeitationID": repetition,
                                      "duration": dur]
        Service.sharedInstance.postJSONRequest(Url: APIManager.APIs.addHealthReportApi, modalName: SubmitTest.self, parameter: request) { (modal, error) in
            Utils.stopLoading()
            if modal?.status == 1{
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
    
    
    //MARK: GET API
    func getDataFrServer(){
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.getHealthTestList, modalName: StatoSaluteModal.self) { (modal, error) in
            Utils.stopLoading()
            guard let arr = modal?.result
            else{
                return
            }
            self.healthListArr = arr
        }
    }
    
    func pickerClicked(data: [String],whCell: Int)
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
                
                if whCell == 0{
                    let index = self?.listArr.firstIndex(of: name)
                    self?.selectedHealthIndex = (self?.healthListArr[index!].id)!
                    self?.healthActivity = name
                }else if whCell == 1{
                    let index = self?.freqArr.firstIndex(of: name)
                    self?.selectedFreq = (self?.modalArray[index!].id)!
                    self?.frequency = name
                }else if whCell == 2{
                    self?.repetition = name
                }else{
                    self?.duration = name
                    
                }
                self?.tableView.reloadData()
                    
                }
            
            
        }, cancelHandler: {
            print("Canceled Styled Picker")
        }, selectionChangedHandler: { (selections: [Int:String], componentThatChanged: Int) -> Void  in
            let newSelection = selections[componentThatChanged] ?? "Failed to get new selection!"
            print("Component \(componentThatChanged) changed value to \(newSelection)")
        })
        
        
        
    }
}
