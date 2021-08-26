//
//  DocTestViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 16/12/2020.
//

import UIKit

class DocTestViewController: UIViewController {
    
    //Variables
    var testScore : GetTestResultsModal?
    var testArray = [ScoreModal]()
    var navTitle = ""
    var testId = Int()
    var groupTestId = Int()
    var type : TestType = .tai
    
    //outlets
 
    @IBOutlet weak var subHeadingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  commonNavigationBar(title: navTitle, controller: Constant.Controllers.docTest, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        navTitleUI(title: navTitle)
        tableViewProperty()
        subHeadingLblUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTestResultsFromServer(testId: testId, groupTstId: groupTestId)
    }
    

    
    func tableViewProperty(){
        tableView.register(UINib(nibName: "TestSampreSec1TableViewCell", bundle: nil), forCellReuseIdentifier: "TestSampreSec1TableViewCell")
        tableView.register(UINib(nibName: "AddPromemoriaTableViewCell", bundle: nil), forCellReuseIdentifier: "AddPromemoriaTableViewCell")
        tableView.register(UINib(nibName: "MenuHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuHeaderTableViewCell")
        tableView.register(UINib(nibName: "TestCatTableViewCell", bundle: nil), forCellReuseIdentifier: "TestCatTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
  
    func subHeadingLblUI(){
       
        subHeadingLbl.text = "Punteggio totale"
        subHeadingLbl.textColor = UIColor.docThemeColor
        subHeadingLbl.font = UIFont(name: AppFontName.regular, size: 14)
        
    }

}
extension DocTestViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return 1
        }
        else if section == 1{
            return 1
        }
        else{
                return testArray.count

           
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
        
        vw.headerLbl.isHidden = true
        vw.bgView.backgroundColor = UIColor.docThemeColor
        let font =  UIFont(name: AppFontName.bold, size: 18)
        vw.midheaderLblUI(font: font!, color: UIColor.white)
        vw.midHeaderLbl.text = type == .tai ? AppUtils.showResultForTai(score: testScore?.finalScore ?? 0) : AppUtils.showResultForCat(score: testScore?.finalScore ?? 0)
        
        return vw
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestSampreSec1TableViewCell", for: indexPath) as! TestSampreSec1TableViewCell
            cell.roundViewUI(color: UIColor.docThemeColor)
            cell.numLbl.text = String(describing: testScore?.finalScore ?? 0)
            cell.displyNumUI(color: .white)
            return cell
   
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderTableViewCell", for: indexPath) as! MenuHeaderTableViewCell
            cell.headerLbl.isHidden  = true
            cell.midHeaderLbl.text = "Dettaglio test"
            cell.bgView.backgroundColor = .clear
            let font =  UIFont(name: AppFontName.regular, size: 14)
            cell.midheaderLblUI(font: font!, color: UIColor.docThemeColor)
            
            
          return cell
        }
       
        else{
            
            if type == .cat {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TestCatTableViewCell", for: indexPath) as! TestCatTableViewCell
                
                
                if let ques = testArray[indexPath.row].question
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
          
                    
                cell.midLblUI(title: testArray[indexPath.row].name ?? "", color: .docThemeColor)
                
                
                return cell

            }else{

          
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPromemoriaTableViewCell", for: indexPath) as! AddPromemoriaTableViewCell
            
           
            cell.lblUI(txt: testArray[indexPath.row].question ?? "", color: UIColor.lineColor, font: UIFont.textFont)
            cell.ansLblUI(txt: testArray[indexPath.row].name ?? "" , color: UIColor.docThemeColor, font: UIFont.txtFontBold)
           
           return cell
            }
        }
    }
    
    
}
extension DocTestViewController
{
    
    
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
                self.testArray = (self.testScore?.results)!
            }
            self.tableView.reloadData()
        
            }
       
    }
}
