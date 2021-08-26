//
//  StoricoListViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 29/01/2021.
//

import UIKit
import McPicker

class StoricoListViewController: UIViewController {
    //variables
    var storicoListArr = [TestAssessmentModal]()
    var type : TestType = .cat
    var dateArr = [String]()
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noTestHistoryLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str = (type == .tai) ? "Archivio Test Tai" : "Archivio Test Cat"
        commonNavigationBar(title: str, controller: Constant.Controllers.storicoList, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        
        tableViewProperty()


    }
    override func viewWillAppear(_ animated: Bool) {
        
        getTestHistoryApi()

//        if self.type == .tai{
//        }else{
//
//        }
    }
    
    func headingLblUI(){
        headingLbl.text = "Archivio Test"
        headingLbl.font = UIFont(name: AppFontName.ralewayBold, size: 20)
        headingLbl.textColor = UIColor.lineColor
    }
    
    func noTestHistoryLblUI()
    {
        self.noTestHistoryLbl.text = "NESSUN TEST STORICO"
        self.noTestHistoryLbl.font = UIFont.appTitle
        self.noTestHistoryLbl.textColor = UIColor.patientThemeColor
    }
    
    func tableViewProperty()
    {
        tableView.register(UINib(nibName: "StoricoListTableViewCell", bundle: nil), forCellReuseIdentifier: "StoricoListTableViewCell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    

   

}
extension StoricoListViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storicoListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoricoListTableViewCell", for: indexPath) as! StoricoListTableViewCell
        
        cell.dropImg.isHidden  = true
        cell.dropBtn.isHidden = true
        
        if  storicoListArr[indexPath.row].test_status == 2{
            cell.mainViewUI(color: .patientThemeColor)
        }else
        {
            //        return UIColor(red: 185/255, green: 05/255, blue: 103/255, alpha: 1)

            cell.mainViewUI(color: UIColor(red: 185/255, green: 05/255, blue: 103/255, alpha: 0.5))
        }
        
        
        cell.lblUI(color: .white, font: UIFont.txtFontBold)
        
        guard let type = storicoListArr[indexPath.row].type, let date = storicoListArr[indexPath.row].start_date?.toDate(), let repetition = storicoListArr[indexPath.row].repetitions,let freq = storicoListArr[indexPath.row].frequency
        else{
            return cell
        }
       

        
//        if storicoListArr[indexPath.row].results?.count ?? 0 > 0 {
//            cell.dropImg.isHidden = false
//            cell.dropBtn.isHidden = false
//
//        }
        
        cell.testType.text = "TEST \(type) \(indexPath.row + 1)"
        cell.dateLbl.text = date
        cell.repetitionLbl.text = "RIPETIZIONI: \(repetition)"
        cell.frequencyLbl.text = "FREQUENZA: OGNI \(freq) GIORNI"
        
        if let desc = storicoListArr[indexPath.row].Desc
        {
//            if array.count > 0 {
//                cell.frequencyLbl.text = "FREQUENZA: \(array[0].Desc!)"
//            }
            cell.frequencyLbl.text = "FREQUENZA: \(desc)"

        }
        cell.delegate = self
        cell.cellTag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = Constant.Controllers.archiveTestList.get() as! ArchiveTestListViewController
        vc.cellNo = indexPath.row + 1
        vc.testData = storicoListArr[indexPath.row]
        vc.type = self.type
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
}

extension StoricoListViewController : StoricoListCellDelegate{
    
    func dropDwnBtnClckd(cell: Int?) {
        
        if let resultsArr = self.storicoListArr[cell!].results
        {
           pickerClicked(resultArr: resultsArr)
        }
    }
        
        
}
    

    



extension StoricoListViewController
{
    func getTestHistoryApi(){
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Test_History, modalName: [TestAssessmentModal].self) { (modal, error) in
            Utils.stopLoading()
            
            self.storicoListArr.removeAll()
            if modal != nil
            {
                
                
                for item in modal!
                {
                    
                   
                    if self.type == .tai {
                        
                        if item.type == "TAI" {
                            self.storicoListArr.append(item)
                        }
                        
                    }else
                    {
                        if item.type == "CAT" {
                            self.storicoListArr.append(item)
                        }
                    }
                    
                    
                }
                
                
                
            }
            
            
            
            for var (index,item) in self.storicoListArr.enumerated()
            {
                
               if let array = item.description
               {
                for data in array
                {
                    if item.frequency == data.id
                    {
                        item.Desc = data.Desc
                        self.storicoListArr[index] = item
                        break;
                    }
                    
                }
               }
 
            }
            
            
            
            
            
            
            if self.storicoListArr.count > 0
            {
                self.noTestHistoryLbl.isHidden  = true
                self.headingLblUI()
                
            }else{
                self.tableView.isHidden = true
                self.headingLbl.isHidden = true
                self.noTestHistoryLblUI()

            }
            
            self.tableView.reloadData()
            
        }
    }
    
    
    
    func convertDateFormater(_ date: String) -> String
        {
        
        // 2021-01-29T08:18:10.000000Z
        print("---",date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.000000Z"
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return  dateFormatter.string(from: date!)

        }
    
    func pickerClicked(resultArr : [ResultModal])
   {
        
        self.view.endEditing(true);
        
        var strArr = [String]()
        
        for (index,data) in resultArr.enumerated()
        {
            if let result = data.created_at
            {
             //   let date = AppUtils.getParticularTimeFormat(format: "yyyy-MM-dd", date: result)
               
             //   print("date---- ", self.convertDateFormater(result))
                
                if self.type == .tai {
                    strArr.append("Test Tai \(index + 1)")
                    
                }else
                {
                    strArr.append("Test Cat \(index + 1)")

                }
                
                
            }
        }
        
        
        
        
        let data: [[String]] = [strArr]
        let mcPicker = McPicker(data: data)
        mcPicker.label?.font = UIFont.txtFontBold
        mcPicker.label?.textColor = UIColor.patientThemeColor
        mcPicker.toolbarButtonsColor = UIColor.patientThemeColor
        mcPicker.toolbarBarTintColor = .white
        mcPicker.backgroundColor = .lightGray
        //mcPicker.backgroundColorAlpha = 0.50
        mcPicker.pickerBackgroundColor = .white

        
        mcPicker.show(doneHandler: { [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
            //    self?.testTF.text = name
                
                if let index = strArr.firstIndex(of: name)
                {
                    let batchNumber = resultArr[index].batch_number
                    print("batchNumber ", batchNumber)
                    let vc = Constant.Controllers.testSampre.get() as! TestSampreViewController
                    vc.whPage = true
                    vc.type = self!.type
                    if let batch = batchNumber
                    {
                    vc.batchNo = batch
                    }
                    self?.navigationController?.pushViewController(vc, animated: true)
             
                    
                }
                
            }

            }, cancelHandler: {
                print("Canceled Styled Picker")
            }, selectionChangedHandler: { (selections: [Int:String], componentThatChanged: Int) -> Void  in
                let newSelection = selections[componentThatChanged] ?? "Failed to get new selection!"
                print("Component \(componentThatChanged) changed value to \(newSelection)")
            })
        

        
    }
}

