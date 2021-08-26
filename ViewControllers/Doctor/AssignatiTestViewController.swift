//
//  AssignatiTestViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 20/01/2021.
//

import UIKit

class AssignatiTestViewController: UIViewController {
    
    //variables
    var batchNo = ""
    var testArr = [TestAssessmentModal]()
    var usedTestArr = [UsedTestList]()
    var navtitle = ""
    var fromPage = false
    var grpTestId = Int()
    var type = ""
    var cellNo = Int()
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var btnLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noTestListLbl: UILabel!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fromPage == false{
            
            commonNavigationBar(title: "Test", controller: Constant.Controllers.assignatiTest, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        }else{
            
            navTitleUI(title: navtitle)
        }
        
        btnLblUI()
        addRefreshControl()
        tableViewProperty()
    }
    
    func addRefreshControl()
    {
            refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        refreshControl.tintColor = .docThemeColor
            // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refreshPulled()
    {
        refreshPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Utils.startLoadingWithTitle("")
       refreshPage()
        
    }
    
    
    func refreshPage()
    {
        if fromPage == true{
            getTestHistoryPerformedByPatient(grpTstId: grpTestId)
        }else{
            if let userId = Utils.getStringForKey(ClassConstants.Datakeys.userId){
                getTestListApi(docId: Int(userId)!)
            }
        }
    }
    
    func noTstAssgndLblUI()
    {
        noTestListLbl.text = "NESSUN TEST ASSEGNATO"
        noTestListLbl.numberOfLines = 2
        noTestListLbl.font = UIFont.appHeadingBody
        noTestListLbl.textColor = UIColor.docThemeColor
    }
    
    
    
    func headingLblUI()
    {
        headingLbl.text = batchNo
        headingLbl.font = UIFont(name: AppFontName.ralewayBold, size: 20)
        headingLbl.textColor = UIColor.docThemeColor
    }
    
    func btnLblUI()
    {
        btnLbl.text = "ASSEGNA NUOVO TEST"
        btnLbl.font = UIFont.btnFont
        btnLbl.textColor = UIColor.headingColor
    }
    
    func tableViewProperty(){
        tableView.register(UINib(nibName: "AssignatiTestTableViewCell", bundle: nil), forCellReuseIdentifier: "AssignatiTestTableViewCell")
        tableView.register(UINib(nibName: "TestGroupListTableViewCell", bundle: nil), forCellReuseIdentifier: "TestGroupListTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    @IBAction func assignNewTestActn(_ sender: Any) {
        
        let vc = Constant.Controllers.assegnaTest.get() as! AssegnaTestViewController
        vc.batchNo = self.batchNo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
extension AssignatiTestViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fromPage == true{
            return self.usedTestArr.count
        }else{
            return self.testArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if fromPage == true{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestGroupListTableViewCell", for: indexPath) as! TestGroupListTableViewCell
            
            guard let status  =  self.usedTestArr[indexPath.row].Status
            
            else{
                return cell
            }
            
            cell.testLblUI(txt: "TEST \(self.type) - \(cellNo) - \(indexPath.row + 1)", color: UIColor.docShadowColor)
            cell.dropImg.isHidden = false
            if status == 0 {
                cell.testLbl.textColor = .quesColor
                cell.dropImg.isHidden = true
            }
            cell.mainVw.backgroundColor = .white
            cell.mainVw.makeCorner(withRadius: 20)
          
            
            return cell
            
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AssignatiTestTableViewCell", for: indexPath) as! AssignatiTestTableViewCell
            
            
            
            guard let type = testArr[indexPath.row].type, let status = testArr[indexPath.row].test_status, let date = testArr[indexPath.row].created_at?.toDate()
            else{
                return cell
            }
            
            if status == 2{
                cell.mainViewUI(color: UIColor.docThemeColor)
            }else{
                cell.mainViewUI(color: UIColor.docFadeColor)
            }
            
            let test = "TEST \(type) - \(indexPath.row + 1) - \(date)"
            cell.testLblUI(test: test)
            
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if fromPage == true{
            
            guard let status  =  self.usedTestArr[indexPath.row].Status
            
            else{
                return
            }
            
            if status == 0{
                
            }else{
                
                
                let vc = Constant.Controllers.docTest.get() as! DocTestViewController
                vc.navTitle = self.navtitle
                if let grpTstId = self.usedTestArr[indexPath.row].assignedtestid{
                vc.groupTestId = grpTstId
                }
                if let id = self.usedTestArr[indexPath.row].id{
                    vc.testId = id
                }
                vc.type = self.type == "TAI" ? .tai : .cat
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        }else{
            guard var type = testArr[indexPath.row].type, let date = testArr[indexPath.row].created_at?.toDate(), let id = testArr[indexPath.row].id, let status = testArr[indexPath.row].test_status
            else{
                return
            }
            
//           if status == 0{
//
//            }else{
            
            let vc = Constant.Controllers.assignatiTest.get() as! AssignatiTestViewController
            vc.batchNo = self.batchNo
            vc.fromPage = true
            vc.grpTestId = id
            vc.cellNo = indexPath.row + 1
            vc.type = type
            
            if type == "TAI"
            {
                type = "Tai"
            }else{
                type = "Cat"
            }
            
            let test = "Test \(type) - \(indexPath.row + 1) - \(date)"
            
            vc.navtitle = test
            self.navigationController?.pushViewController(vc, animated: true)
     //       }
        }
        
    }
}

extension AssignatiTestViewController{
    
    
    
    func getTestHistoryPerformedByPatient(grpTstId : Int)
    {
        
        let post : [String : Any] = ["assignedTestId": grpTstId,
                                     "patientId": AppUtils.AppDelegate().patientId]
        Service.sharedInstance.postJSONRequest(Url: APIManager.APIs.test_PerformedBy_Patient, modalName: TestHistoryTakenByPatientModal.self, parameter: post) { (modal, error) in
            self.refreshControl.endRefreshing()

            Utils.stopLoading()
            
            if modal != nil
            {
                if let arr = modal?.results
                {
                    self.usedTestArr = arr
                }
            }
            if self.usedTestArr.count > 0
            {
                self.noTestListLbl.isHidden = true
                self.tableView.isHidden = false
                self.headingLblUI()
                self.tableView.reloadData()
                
                
            }else{
                self.noTestListLbl.isHidden = false
                self.noTstAssgndLblUI()
                self.headingLbl.isHidden = true
                self.tableView.isHidden = true
                
                
            }
            
            
            self.tableView.reloadData()
            
            
            
        }
        
    }
    
    
    
    //  Assigned  Test List Api
    func getTestListApi(docId: Int)
    {
        
        
        let post : [String : Any] = ["patientId": AppUtils.AppDelegate().patientId,
                                     "doctorId": docId]
        Service.sharedInstance.postJSONRequest(Url: APIManager.APIs.get_Assigned_TestList, modalName: TestModal.self, parameter: post){ (modal, error) in
            self.refreshControl.endRefreshing()
            Utils.stopLoading()
            
            if modal != nil
            {
                if let arr = modal?.testList
                {
                    self.testArr = arr
                }
                
            }
            if self.testArr.count > 0
            {
                self.noTestListLbl.isHidden = true
                self.headingLblUI()
                self.tableView.isHidden = false
                
                
            }else{
                self.noTestListLbl.isHidden = false
                self.noTstAssgndLblUI()
                self.headingLbl.isHidden = true
                self.tableView.isHidden = true
                
                
            }
            
            
            self.tableView.reloadData()
            
        }
        
    }
}
