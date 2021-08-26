//
//  ArchiveTestListViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 15/02/2021.
//

import UIKit

class ArchiveTestListViewController: UIViewController {
    
    var type : TestType = .cat
    var cellNo = Int()
    var testData : TestAssessmentModal?
    var testListArr = [UsedTestList]()
    
    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str = (type == .tai) ? "Archivio Test Tai" : "Archivio Test Cat"
        commonNavigationBar(title: str, controller: Constant.Controllers.archiveTestList, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        
        tablePropertyUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let grpTestId = testData?.id , let id = Utils.getStringForKey(ClassConstants.Datakeys.userId)
        else{return}
        
        getTestHistoryPerformedByPatient(grpTstId: grpTestId, userId: Int(id)!)
        
    }
    
    func tablePropertyUI()
    {
        tableView.register(UINib(nibName: "StoricoListTableViewCell", bundle: nil), forCellReuseIdentifier: "StoricoListTableViewCell")
        tableView.register(UINib(nibName: "TestGroupListTableViewCell", bundle: nil), forCellReuseIdentifier: "TestGroupListTableViewCell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
}

extension ArchiveTestListViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return self.testListArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoricoListTableViewCell", for: indexPath) as! StoricoListTableViewCell
            
            cell.dropImg.isHidden = true
            cell.dropBtn.isHidden = true
            
            cell.mainViewUI(color: .clear)
            cell.lblUI(color: .lineColor, font: .appHeadingBody)
            
            guard let type = testData?.type, let date = testData?.start_date?.toDate(), let repetition = testData?.repetitions,let freq = testData?.frequency
            else{
                return cell
            }
            
            cell.testType.text = "TEST \(type) \(cellNo)"
            cell.dateLbl.text = date
            cell.repetitionLbl.text = "RIPETIZIONI: \(repetition)"
            
            
            
            cell.frequencyLbl.text = "FREQUENZA: OGNI \(freq) GIORNI"
            
            
            if let desc = testData?.Desc
            {
                //            if array.count > 0 {
                //                cell.frequencyLbl.text = "FREQUENZA: \(array[0].Desc!)"
                //            }
                cell.frequencyLbl.text = "FREQUENZA: \(desc)"
                
            }
            
            
            
            return cell
            
        }
        
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestGroupListTableViewCell", for: indexPath) as! TestGroupListTableViewCell
            
            var type = ""
            cell.mainVw.backgroundColor = .white
            cell.mainVw.makeCorner(withRadius: 20)
            
            guard let status  =  self.testListArr[indexPath.row].Status
            
            else{
                return cell
            }
            
            if self.type == .tai{
                type = "TAI"
            }else{
                type = "CAT"
            }
            
            cell.testLblUI(txt: "TEST \(type) - \(cellNo) - \(indexPath.row + 1)", color: UIColor.patientThemeColor)
            cell.dropImg.isHidden = false
            cell.dropImg.image = UIImage(named: "patDropImg")
            if status == 0 {
                cell.testLbl.textColor = .quesColor
                cell.dropImg.isHidden = true
            }
            
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let id = self.testListArr[indexPath.row].id, let groupId = self.testListArr[indexPath.row].assignedtestid, let status  =  self.testListArr[indexPath.row].Status, let date = testData?.start_date?.toDate() else {
            return
        }
        
        if status == 0{
            
        }else{
            let vc = Constant.Controllers.testSampre.get() as! TestSampreViewController
            vc.whPage = true
            vc.type = self.type
            vc.testId = id
            vc.groupTestId = groupId
            vc.testNo = indexPath.row + 1
            vc.totalTestCount = testListArr.count
            let test = "Test \(type) - \(cellNo) - \(date)"
            
            vc.navtitle = test
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension ArchiveTestListViewController
{
    func getTestHistoryPerformedByPatient(grpTstId: Int, userId: Int)
    {
        Utils.startLoadingWithTitle("")
        
        let post : [String : Any] = ["assignedTestId": grpTstId,
                                     "patientId": userId]
        Service.sharedInstance.postJSONRequest(Url: APIManager.APIs.test_PerformedBy_Patient, modalName: TestHistoryTakenByPatientModal.self, parameter: post) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil
            {
                if let arr = modal?.results
                {
                    self.testListArr = arr
                }
            }
            //            if self.testListArr.count > 0
            //            {
            //                self.noTestListLbl.isHidden = true
            //                self.headingLblUI()
            //
            //
            //            }else{
            //                self.noTestListLbl.isHidden = false
            //                self.noTstAssgndLblUI()
            //
            //
            //            }
            
            
            self.tableView.reloadData()
            
            
            
        }
        
    }
    
}
