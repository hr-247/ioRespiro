//
//  PatientAssignatiViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 28/01/2021.
//

import UIKit

class PatientAssignatiViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //variables
    var testNmeArr = ["TEST TAI","TEST CAT"]
    var testAssignedArr = [TestAssessmentModal]()
    var taiArr = [TestAssessmentModal]()
    var catArr = [TestAssessmentModal]()
    var taiCompletedArr = [TestAssessmentModal]()
    var catCompletedArr = [TestAssessmentModal]()
    var dataArr : testEnableModal?
    
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var noTstAssgndLbl: UILabel!
    @IBOutlet weak var testHistoryLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var assigndTstTV: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonNavigationBar(title: "Test", controller: Constant.Controllers.patientAssignati, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        testTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        testBtnEnbleApi()
        //  getAssignedTest()
    }
    
    func lblUI()
    {
        headingLbl.text = "Test assegnati"
        headingLbl.font = UIFont(name: AppFontName.ralewayBold, size: 20)
        headingLbl.textColor = UIColor.lineColor
        
        testHistoryLbl.text = "Archivio Test"
        testHistoryLbl.font = UIFont(name: AppFontName.ralewayBold, size: 20)
        testHistoryLbl.textColor = UIColor.lineColor
        
    }
    
    func testTableView()
    {
        assigndTstTV.register(UINib(nibName: "AssignatiTestTableViewCell", bundle: nil), forCellReuseIdentifier: "AssignatiTestTableViewCell")
        assigndTstTV.separatorStyle = .none
        assigndTstTV.delegate = self
        assigndTstTV.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func noTestHistoryLblUI()
    {
        self.noTstAssgndLbl.text = "NESSUN TEST ASSEGNATO"
        self.noTstAssgndLbl.font = UIFont.appTitle
        self.noTstAssgndLbl.textColor = UIColor.patientThemeColor
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
    
    
    
}
extension PatientAssignatiViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == assigndTstTV
        {
            
            if section == 0 {
                if self.taiArr.count > 0 || self.dataArr?.taiFutureTest == 1 {
                    return 1
                }
                return 0
                
            }else
            {
                if self.catArr.count > 0 || self.dataArr?.catFutureTest == 1 {
                    return 1
                }
                return 0
            }
            
            
            
            
            
            
            
            if self.catArr.count > 0 && self.taiArr.count > 0{
                return 2
            }
            else if self.catArr.count == 0 && self.taiArr.count == 0{
                if self.dataArr?.taiFutureTest == 1 && self.dataArr?.catFutureTest == 1{
                    return 2
                }
                else if self.dataArr?.taiFutureTest == 0 && self.dataArr?.catFutureTest == 0{
                    return 0
                }
                else{
                    return 1
                }
            }else{
                
                if self.dataArr?.taiFutureTest == 1 || self.dataArr?.catFutureTest == 1{
                    return 2
                }else{
                return 1
                }
            }
        }else{
            
            if section == 0 {
                if self.taiCompletedArr.count > 0 {
                    return 1
                }
                return 0
            }else
            {
                if self.catCompletedArr.count > 0 {
                    return 1
                }
                return 0
            }
            
            
            
            if self.catCompletedArr.count > 0 && self.taiCompletedArr.count > 0{
                return 2
            }else if self.catCompletedArr.count == 0 && self.taiCompletedArr.count == 0{
                return 0
            }else{
                return 1
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == assigndTstTV
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AssignatiTestTableViewCell", for: indexPath) as! AssignatiTestTableViewCell
            
            
            cell.mainView.makeCorner(withRadius: 30)
      
            
            
            if indexPath.section == 0{
                if  taiArr.count > 0{
                    cell.mainView.backgroundColor = UIColor.patientThemeColor
                }
                else if self.dataArr?.taiFutureTest == 1{
                    cell.mainView.backgroundColor = UIColor.borderColor
                } else{
                    cell.mainView.isHidden = true
                }
            }
            
            
            if indexPath.section == 1{
                if catArr.count > 0{
                    cell.mainView.backgroundColor = UIColor.patientThemeColor
                }
                else if self.dataArr?.catFutureTest == 1{
                    cell.mainView.backgroundColor = UIColor.borderColor
                }
                else{
                    cell.mainView.isHidden = true
                }
                
            }
            
            
            
            
            // cell.mainViewUI(color: UIColor.patientThemeColor)
            
            //            guard let type = testAssignedArr[indexPath.row].type, let freq = testAssignedArr[indexPath.row].frequency, let date = testAssignedArr[indexPath.row].start_date
            //            else{
            //                return cell
            //            }
            //
            //            let test = "TEST \(type) - \(freq) - \(date)"
            //            cell.testLblUI(test: test)
            
            if indexPath.section == 0{
                cell.testLblUI(test: "TEST TAI")
            }else{
                cell.testLblUI(test: "TEST CAT")
            }
            
            
            return cell
            
        }else{
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoricoCell", for: indexPath) as! StoricoCell
            
            
            if indexPath.section == 0{
                cell.lblUI(txt: "TEST TAI")
            }
            
            
            if indexPath.section == 1
            {
                cell.lblUI(txt: "TEST CAT")
                cell.topView.isHidden = true
                if taiCompletedArr.count == 0 && catCompletedArr.count > 0{
                    cell.topView.isHidden = false
                }
            }
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == assigndTstTV
        {
            
            if indexPath.section == 0{
                if self.taiArr.count > 0 {
                    
                    guard let id = self.taiArr[0].id, let assigndId = self.taiArr[0].assignedtestid,let freq = self.taiArr[0].frequency
                    else{
                        return
                    }
                    let vc = Constant.Controllers.testTai.get() as! TestTaiViewController
                    vc.whchBtnClckd = false
                    vc.type = .tai
                    vc.testId = id
                    vc.assignedTestId = assigndId
                    vc.freqId = freq
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }else{
                
                if self.catArr.count > 0 {
                    guard let id = self.catArr[0].id, let assigndId = self.catArr[0].assignedtestid,let freq = self.catArr[0].frequency
                    else{
                        return
                    }
                    let vc = Constant.Controllers.testTai.get() as! TestTaiViewController
                    vc.whchBtnClckd = true
                    vc.type = .cat
                    vc.testId = id
                    vc.assignedTestId = assigndId
                    vc.freqId = freq
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            
        }else{
            
            if indexPath.section == 0
            {
                let vc = Constant.Controllers.storicoList.get() as! StoricoListViewController
                vc.type = .tai
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                let vc = Constant.Controllers.storicoList.get() as! StoricoListViewController
                vc.type = .cat
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
}


extension PatientAssignatiViewController
{
    
    
    func getAssignedTest(){
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Assigned_Test, modalName: TestModal.self) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil
            {
                if let tests = modal?.tests
                {
                    self.testAssignedArr = tests
                }
            }
            
            if self.testAssignedArr.count > 0
            {
                self.noTstAssgndLbl.isHidden = true
                self.lblUI()
                self.assigndTstTV.reloadData()
                
                
            }else{
                self.noTstAssgndLbl.isHidden = false
                self.noTestHistoryLblUI()
                self.headingLbl.isHidden = true
                self.tableView.isHidden = true
                self.testHistoryLbl.isHidden = true
                self.assigndTstTV.isHidden = true
                
            }
            
        }
    }
    
    //to check which test button to enable
    func testBtnEnbleApi()
    {
        Utils.startLoadingWithTitle("")
        
        guard let id = Utils.getStringForKey(ClassConstants.Datakeys.userId)
        else{return}
        
        let startDate = Date().startOfDay.timeStamp
        let endDate = Date().endOfDay.timeStamp
        
        let post : [String : Any] = ["patientId": id,
                                     "startTime":startDate,
                                     "endTime":endDate]
        
        Service.sharedInstance.postJSONRequest(Url: APIManager.APIs.today_TestList, modalName: testEnableModal.self, parameter: post) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil{
                
                self.dataArr = modal
                
                if let arr = self.dataArr?.catTestList{
                    self.catArr = arr
                }
                if let arr = self.dataArr?.taiTestList{
                    self.taiArr = arr
                }
                if let arr = self.dataArr?.taiCompletedTestList{
                    self.taiCompletedArr = arr
                }
                if let arr = self.dataArr?.catCompletedTestList{
                    self.catCompletedArr = arr
                }
                
            }
            
            guard let taiCompleted = self.dataArr?.taiCompletedTestList, let catCompleted = self.dataArr?.catCompletedTestList else {return}
            
            
            if self.catArr.count > 0 ||  self.taiArr.count > 0 || taiCompleted.count > 0 || catCompleted.count > 0 || self.dataArr?.taiFutureTest == 1 || self.dataArr?.catFutureTest == 1{
                self.noTstAssgndLbl.isHidden = true
                
                self.assigndTstTV.reloadData()
            }else{
                self.noTstAssgndLbl.isHidden = false
                self.noTestHistoryLblUI()
            }
            
            if self.catArr.count > 0 ||  self.taiArr.count > 0 || self.dataArr?.taiFutureTest == 1 || self.dataArr?.catFutureTest == 1
            {
                self.headingLbl.isHidden = false
                self.lblUI()
            }else
            {
                self.headingLbl.isHidden = true
            }
            
            
            
            
            if catCompleted.count > 0 || taiCompleted.count > 0{
                self.tableView.isHidden = false
                self.testHistoryLbl.isHidden = false
                self.lblUI()
                self.tableView.reloadData()
                
            }else{
                self.tableView.isHidden = true
                self.testHistoryLbl.isHidden = true
            }
            
            
        }
    }
}
