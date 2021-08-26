//
//  TestSampreViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 10/12/2020.
//

import UIKit

class TestSampreViewController: UIViewController {
    
    //outlets

    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var testSampreTableView: UITableView!
    
    var testScore : GetTestResultsModal?
    var testArray2 = [ScoreModal]()
    var testArray = [TestAnswer]()
    var catTestArray = [CatTestAnswer]()
    var type : TestType = .tai
    var score = 0
    var batchNo = ""
    var whPage = false
    var testId = Int()
    var groupTestId = Int()
    var navtitle = ""
    var testNo = Int()
    var totalTestCount = Int()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if whPage == true{
            patNavTitleUI(title: navtitle)
        }else{
        
        commonNavigationBar(title: "Test", controller: Constant.Controllers.testSampre, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        }
        
        tableViewProperty()
        headingLblProperty()
     //   addBackButton()
        if type == .tai {
            calculateScore()
        }else
        {
            calculateCatScore()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if whPage == true{
      //  getTestResultsFromServer()
            getTestResultsFromServer(testId: testId,groupTstId: groupTestId)
        }
    }
    
    
    
    func headingLblProperty()
    {
        
        headingLbl.text = "Punteggio totale"
        headingLbl.textColor = UIColor.docThemeColor
        headingLbl.font = UIFont(name: AppFontName.regular, size: 14)

    }
    
    func calculateScore()
    {
        
        for item in testArray
        {
            if let value = item.answer?.score
            {
                score = score + value
            }
            
        }
        self.testSampreTableView.reloadData()
    }
    
    func calculateCatScore()
    {
        
        for item in catTestArray
        {
            if let value = item.answer?.score
            {
                score = score + value
            }
            
        }
        self.testSampreTableView.reloadData()
    }
    
    
    func tableViewProperty()
    {
        
        testSampreTableView.register(UINib(nibName: "TestCatTableViewCell", bundle: nil), forCellReuseIdentifier: "TestCatTableViewCell")
        testSampreTableView.register(UINib(nibName: "TestSampreSec1TableViewCell", bundle: nil), forCellReuseIdentifier: "TestSampreSec1TableViewCell")
        testSampreTableView.register(UINib(nibName: "AddPromemoriaTableViewCell", bundle: nil), forCellReuseIdentifier: "AddPromemoriaTableViewCell")
        testSampreTableView.register(UINib(nibName: "MenuHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuHeaderTableViewCell")
        testSampreTableView.register(UINib(nibName: "TestResultSec4TableViewCell", bundle: nil), forCellReuseIdentifier: "TestResultSec4TableViewCell")
        testSampreTableView.delegate = self
        testSampreTableView.dataSource = self
        testSampreTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    
    
    
}
extension TestSampreViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if whPage == true{
            return 4
        }else{
        return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0
//        {
//            return 1
//        }
//        else if section == 1{
//            return 1
//        }
//        else{
        
        if section == 2{
            if whPage == true{
//                return type == .tai ?  testArray2.count : catTestArray.count
                return testArray2.count

            }else{
            
            return type == .tai ?  testArray.count : catTestArray.count
            }
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
        return 40
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let  vw = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderTableViewCell") as! MenuHeaderTableViewCell
     //   vw.bgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        vw.headerLbl.isHidden = true
        vw.bgView.backgroundColor = UIColor.patientThemeColor
        let font =  UIFont(name: AppFontName.bold, size: 18)
        vw.midheaderLblUI(font: font!, color: UIColor.white)
        
        
        let finalS = (whPage == true) ? testScore?.finalScore ?? 0 : score
        
        
        
        vw.midHeaderLbl.text = type == .tai ? AppUtils.showResultForTai(score: finalS) :  AppUtils.showResultForCat(score: finalS)
        
        return vw
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestSampreSec1TableViewCell", for: indexPath) as! TestSampreSec1TableViewCell
            cell.roundViewUI(color: UIColor.patientThemeColor)
            
            if whPage == true{
                cell.numLbl.text = String(describing: testScore?.finalScore ?? 0)
            }else{
                cell.numLbl.text = "\(score)"
            }
            
        //    cell.bottomTextUI(color: UIColor.patientThemeColor, title: "Dettaglio Test")
            cell.displyNumUI(color: UIColor.white)
            return cell
        
            
        }
        
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderTableViewCell", for: indexPath) as! MenuHeaderTableViewCell
            cell.headerLbl.isHidden  = true
            cell.midHeaderLbl.text = "Dettaglio test"
            cell.bgView.backgroundColor = .clear
            let font =  UIFont(name: AppFontName.regular, size: 14)
            cell.midheaderLblUI(font: font!, color: .docThemeColor)
            
            
          return cell
        }
        else if indexPath.section == 3
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestResultSec4TableViewCell", for: indexPath) as! TestResultSec4TableViewCell
            
            cell.lbl.text = "RIPETIZIONE \(self.testNo)/\(self.totalTestCount)"
            cell.lblUI(color: .patientThemeColor)
            
            
            return cell
            
        }
      
        else{
            
            if type == .cat {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TestCatTableViewCell", for: indexPath) as! TestCatTableViewCell
                
                if whPage == true{
                    
                    // change here
                    
                    if let ques = testArray2[indexPath.row].question
                    {
                        
                        let data = ques.data(using: .utf8)!
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String : String]
                            {
                               print(json) // use the json here
                                cell.leftLblUI(title: json["top"]!)
                                cell.rightLblUI(title: json["bottom"]!)
                                
                                
                            } else {
                                print("bad json")
                            }
                        } catch let error as NSError {
                            print(error)
                            cell.leftLblUI(title: ques)
                            cell.rightLblUI(title: ques)

                        }
                    }
                    
                    
                    cell.midLblUI(title: testArray2[indexPath.row].name ?? "", color: .patientThemeColor)

                    
                }else
                {
                
                cell.leftLblUI(title: catTestArray[indexPath.row].question?.question?.top ?? "")
                cell.rightLblUI(title: catTestArray[indexPath.row].question?.question?.bottom ?? "")
                
                if let score = catTestArray[indexPath.row].answer?.score
                {
                    cell.midLblUI(title: "\(score)", color: .patientThemeColor)
                }
                }
                


                return cell

            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPromemoriaTableViewCell", for: indexPath) as! AddPromemoriaTableViewCell
            
            if whPage == true{
                cell.lblUI(txt: testArray2[indexPath.row].question ?? "", color: UIColor.lineColor, font: UIFont.textFont)
                cell.ansLblUI(txt: testArray2[indexPath.row].name ?? "" , color: UIColor.patientThemeColor, font: UIFont.txtFontBold)
                cell.lineVw.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
                
            }else{
                
            
        
            cell.lblUI(txt: testArray[indexPath.row].question?.question ?? "", color: UIColor.lineColor, font: UIFont.textFont)
            cell.ansLblUI(txt: testArray[indexPath.row].answer?.name ?? "" , color: UIColor.patientThemeColor, font: UIFont.txtFontBold)
            cell.lineVw.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
            }
       
           return cell
        }
    
        
    }
    
    
    
}
extension TestSampreViewController{
    func getTestResultsFromServer()
    {
   
        Utils.startLoadingWithTitle("")
        
        let url = APIManager.APIs.get_Test_Results + "\(batchNo)"
        
        Service.sharedInstance.getRequest(Url: url, modalName: GetTestResultsModal.self) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil
            {
                self.testScore = modal!
                self.testArray2 = (self.testScore?.scores)!
            }
            self.testSampreTableView.reloadData()
        
            }
       
    }
    
    
    func getTestResultsFromServer(testId : Int,groupTstId : Int)
    {
   
        Utils.startLoadingWithTitle("")
        
        let url = APIManager.APIs.get_Test_Results_New
        
        let post : [String : Any] = ["assignedTestId":groupTstId,
                                     "assignedtestschedulemappingid":testId]
        
        Service.sharedInstance.postJSONRequest(Url: url, modalName: GetTestResultsModal.self, parameter: post) { (modal, error) in
        
            Utils.stopLoading()
            
            if modal != nil
            {
                self.testScore = modal!
                self.testArray2 = (self.testScore?.results)!
            }
            self.testSampreTableView.reloadData()
        
            }
       
    }
}


