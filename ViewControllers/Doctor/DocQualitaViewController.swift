//
//  DocQualitaViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 19/01/2021.
//

import UIKit
import CoreLocation

class DocQualitaViewController: UIViewController {
    
    //variable
    var airQualityArr = [AirQuailtaModal]()
    var aqiArr : [CGFloat] = []
    var dateArr : [String] = []
    var moreData = false
    var pageNumber = 1
    var selectedIndex = 99;
    var chart : LineChart? = nil
    var cityName  = ""
    var stationNme = ""
    let ceo: CLGeocoder = CLGeocoder()
    var pollutantArr = [[String]]()
    var pollutantRingArr = [[String]]()
    var dataArrOArr = [[String]]()
    var currentAQI : Int?
    var date : String?
    var selectedButton = 0;

    
    @IBOutlet weak var lineChartView: LineChart!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonNavigationBar(title: "Qualità dell’aria", controller: Constant.Controllers.docQualita, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        tableViewProperty()
        getAirDataFromServer(isleft: true)

       
    }
    
    func tableViewProperty(){
        
        tableView.register(UINib(nibName: "AirQualitaSec1TableViewCell", bundle: nil), forCellReuseIdentifier: "AirQualitaSec1TableViewCell")
        tableView.register(UINib(nibName: "AirQualitaSec2TableViewCell", bundle: nil), forCellReuseIdentifier: "AirQualitaSec2TableViewCell")
        tableView.register(UINib(nibName: "AirQualitaSec3TableViewCell", bundle: nil), forCellReuseIdentifier: "AirQualitaSec3TableViewCell")
        tableView.register(UINib(nibName: "AirQualitySec4TableCell", bundle: nil), forCellReuseIdentifier: "AirQualitySec4TableCell")
        tableView.register(UINib(nibName: "AirQualitaNewSec2TableViewCell", bundle: nil), forCellReuseIdentifier: "AirQualitaNewSec2TableViewCell")

        
    }
    @objc func smilyRangeActn(){
        let vc = Constant.Controllers.rangeChart.get() as! AirQualityChartViewController
        vc.frmDrSide = true
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}


extension DocQualitaViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            
                if aqiArr.count > 0 {
                    return 1
                }
                return 0
            
        }else{
            return 1
        }
        
        
        
        
        if section == 2{
            
            if selectedIndex == 99 {
                return 0
            }
            
            if pollutantArr.count > 0 {
                return pollutantArr[0].count
            }
            return 0

            
        }else if section == 1
        {
            if aqiArr.count > 0 {
                return 1
            }
            return 0
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AirQualitaSec1TableViewCell", for: indexPath) as! AirQualitaSec1TableViewCell
//          //  cell.imgView.image = UIImage(named: "docQualitaTxt")
//            cell.outerView.backgroundColor = .docThemeColor
//            if selectedIndex > self.airQualityArr.count {
//                cell.lblUI(txt: "Grafico AQI")
//            }else
//            {
//                if let aqi = self.airQualityArr[selectedIndex].aqi
//                {
//                    cell.setColor(aqi: aqi)
//                    cell.lblUI(txt: "\(aqi)")
//                }
//            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AirQualitaSec3TableViewCell", for: indexPath) as! AirQualitaSec3TableViewCell
            

            cell.mainVw.roundCorners([.topLeft,.topRight], radius: 15)
            cell.mainVw.backgroundColor = .docThemeColor
            cell.pollutantLbl.text = "I tuoi ultimi spostamenti"
            cell.pollutantLbl.textColor = .white
            cell.pollutantLbl.font = .textFont
            
            
            return cell
            
        }else if indexPath.section == 2{ //Graph Section
            let cell = tableView.dequeueReusableCell(withIdentifier: "AirQualitaSec2TableViewCell", for: indexPath) as! AirQualitaSec2TableViewCell
            
            cell.mainView.backgroundColor = .docThemeColor
            
            if chart == nil {
                cell.lineChartUI(data: self.aqiArr, xLabels: self.dateArr)
                cell.chartView.delegate = self
                chart = cell.chartView
            }
            
            cell.leftButton.isHidden = true
            cell.rigthButton.isHidden = false
            
            if pageNumber == 1 {
                cell.rigthButton.isHidden = true
            }
            if let date = self.date
            {
                cell.dateLblUI(txt: date)
                
            }
            
            if moreData == true {
                cell.leftButton.isHidden = false
            }
            cell.delegate = self
            
            cell.mainView.roundCorners([.bottomLeft,.bottomRight], radius: 15)
            
            let myAttribute = [NSAttributedString.Key.font: UIFont.appTitle]
            let myString = NSMutableAttributedString(string: self.cityName, attributes: myAttribute )
            
            // create attributed string
            let myString2 = "(Stazione di \(self.stationNme))"
            let myAttribute2 = [ NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.profileListFont ]
            let myAttrString = NSAttributedString(string: myString2, attributes: myAttribute2)
            

            cell.cityLbl.text = cell.cityLblUI(txt: "\(self.cityName)(Stazione di \(self.stationNme))")
           // cell.cityLblUI(txt: self.cityName+"(\(self.stationNme))")
            if let aqi = self.currentAQI
            {
            cell.aqiRingUI(aqi: aqi)
            }
            return cell
            
            
        }
        else{
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AirQualitaSec3TableViewCell", for: indexPath) as! AirQualitaSec3TableViewCell
//            cell.pollutantLbl.text = pollutantArr[selectedIndex][indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AirQualitaNewSec2TableViewCell", for: indexPath) as! AirQualitaNewSec2TableViewCell
            cell.bgView.backgroundColor = .docThemeColor
            
            if let aqi = self.currentAQI
            {
                cell.aqi = aqi
                cell.img1Actn(aqi: aqi)
                cell.img2Actn(aqi: aqi)
                cell.img3Actn(aqi: aqi)
            }
            
            cell.hideViews(tag: selectedButton)
            
         //   cell.dscLblUI(txt: "Sintomi all'apparato respiratorio per persone particolarmente sensibili.")
          //  cell.selctdDscLblUI(txt: "Le Categorie Più Sensibili Dovrebbero Ridurre Gli Esercizi All’aperto")
          //  cell.vwForImg1.backgroundColor = .airQualitaYellow
            cell.smilyRangeBtn.addTarget(self, action: #selector(smilyRangeActn), for: .touchUpInside)
            if let aqi = self.currentAQI
            {
            cell.smilyChangeActn(aqi: aqi)
            }
            
            cell.delegate = self
            return cell
        }
    }
    
    
}



extension DocQualitaViewController : LineChartDelegate
{
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
        
        selectedIndex = Int(x)
        let vc = Constant.Controllers.progressRing.get() as! ProgressRingViewController
        vc.stationName = self.stationNme
        vc.pollutantArr = self.pollutantRingArr[selectedIndex]
        vc.nameArr = dataArrOArr[selectedIndex]
        vc.location = self.airQualityArr[selectedIndex].geoLocation
        vc.frmDrSide = true
        vc.date = self.airQualityArr[selectedIndex].createdTime?.toDateFormat(dateFormat: "dd MMM yyyy") ?? ""
        
        
        self.present(vc, animated: true, completion: nil)
    }
    
}



extension DocQualitaViewController
{
    //MARK: get air quality data
    func getAirDataFromServer(isleft : Bool)
    {

  
        Utils.startLoadingWithTitle("")
        
        let request : [String:Any] = [ "userId": AppUtils.AppDelegate().patientId,
                                       "pageNo": pageNumber
                                     ]
        
        Service.sharedInstance.postJSONRequest(Url: APIManager.APIs.getAirQualityDetails, modalName: AirQualitaResponseModal.self, parameter: request) { (modal, error) in
            Utils.stopLoading()
            
            guard let mod = modal else {return}
            
                if let arr = mod.results{
                
 
            if arr.count == 0
            {
                AppUtils.showToast(message: Constant.Msg.noData)
                
            }else
            {
                self.selectedIndex = 99
                if arr.count < 7
                {
                    self.moreData = false
                }else
                {
                    self.moreData = true
                }
                
                self.airQualityArr = arr.reversed()
                if self.pageNumber == 1{
                self.currentAQI = arr[0].aqi
                    self.date = arr[0].createdTime?.toDateFormat(dateFormat: "dd MMM yyyy")}
                self.setData()
            }
        }
            
            
            
            if let city = mod.cityDetails{
                if let coordinate = city.geo
                {
                    let lat = coordinate[0]
                    let long = coordinate[1]
                    self.getRegion(lat: lat, long: long)
                    
                }
                
                if let station = city.name
                {
                    self.stationNme = station
                }
                
            }
 
            self.chart = nil
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
         //   self.tableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .bottom, animated: true)
        }
    
        
    }
    
    func setData()
    {
        
        self.aqiArr.removeAll()
        self.dateArr.removeAll()
        self.pollutantArr.removeAll()
        self.pollutantRingArr.removeAll()
        dataArrOArr.removeAll()
        
        for data in self.airQualityArr{
            if let aqi = data.aqi{
                self.aqiArr.append(CGFloat(aqi))
                self.dateArr.append(data.createdTime?.toShortDate() ?? "N/A")
            
           let p1 = "co" + "   :   " + (data.co ?? "0")
                let p2 = "dew" + "   :   " + (data.dew ?? "0")
                let p3 = "h" + "   :   " + (data.h ?? "0")
                let p4 = "no2" + "   :   " + (data.no2 ?? "0")
                let p5 = "o3" + "   :   " + (data.o3 ?? "0")
                let p6 = "p" + "   :   " + (data.p ?? "0")
                let p7 = "pm10" + "   :   " + (data.pm10 ?? "0")
                let p8 = "pm2.5" + "   :   " + (data.pm25 ?? "0")
                let p9 = "t" + "   :   " + (data.t ?? "0")
                let p10 = "w" + "   :   " + (data.w ?? "0")
                
                
                let r1 = data.co ?? "0"
                let r2 =  data.p ?? "0"
                let r3 =   data.pm10 ?? "0"
                let r4 =  data.pm25 ?? "0"
                let r5 =  data.t ?? "0"
                let r6 = data.w ?? "0"
                let r7 = data.dew ?? "0"
                let r8 = data.h ?? "0"
                let r9 = data.no2 ?? "0"
                let r10 = data.o3 ?? "0"
                
                var ringArr = [String]()
                var dataArr = [String]()

                if data.co != "0" && data.co != "undefined"{
                    ringArr.append(data.co ?? "0")
                    dataArr.append("co")
                    
                }
                if data.p != "0" && data.p != "undefined"{
                    ringArr.append(data.p ?? "0")
                    dataArr.append("p")
                }
                if data.pm10 != "0" && data.pm10 != "undefined"{
                    ringArr.append(data.pm10 ?? "0")
                    dataArr.append("pm10")
                }
                if data.pm25 != "0" && data.pm25 != "undefined"{
                    ringArr.append(data.pm25 ?? "0")
                    dataArr.append("pm25")
                }
                if data.t != "0" && data.t != "undefined"{
                    ringArr.append(data.t ?? "0")
                    dataArr.append("t")
                }
                if data.w != "0" && data.w != "undefined"{
                    ringArr.append(data.w ?? "0")
                    dataArr.append("w")
                }
                if data.dew != "0" && data.dew != "undefined"{
                    ringArr.append(data.dew ?? "0")
                    dataArr.append("dew")
                }
                if data.h != "0" && data.h != "undefined"{
                    ringArr.append(data.h ?? "0")
                    dataArr.append("h")
                }
                if data.no2 != "0" && data.no2 != "undefined"{
                    ringArr.append(data.no2 ?? "0")
                    dataArr.append("no2")
                }
                if data.o3 != "0" && data.o3 != "undefined"{
                    ringArr.append(data.o3 ?? "0")
                    dataArr.append("o3")
                }


                let arr = [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10]
              //  let ringArr = [r1,r2,r3,r4,r5,r6,r7,r8,r9,r10]
                
                
                pollutantArr.append(arr)
                pollutantRingArr.append(ringArr)
                dataArrOArr.append(dataArr)
            }
        }
        
    }
    
    func getRegion(lat: Double,long: Double){
        let location = CLLocation(latitude: lat, longitude: long)
        ceo.reverseGeocodeLocation(location, completionHandler:
                    {(placemark, error) in
            if let error = error as? CLError {
                print("CLError:", error)
                return
            } else if let placemark = placemark?.first {
                // you should always update your UI in the main thread
                DispatchQueue.main.async {

//                    self.addrLine1TF.text  = placemark.thoroughfare ?? ""
//                    self.addrLine2TF.text = placemark.subThoroughfare ?? ""
                    self.cityName = placemark.locality ?? ""
                    self.tableView.reloadData()

//                    self.stateTF.text = placemark.administrativeArea ?? ""
//                    self.zipTF.text = placemark.postalCode ?? ""
//                    self.countryTF.text =  placemark.country ?? ""

                }
            }
        })
    }
}





extension DocQualitaViewController : AirQualityCellDelegate
{
    func leftBtnClicked()
    {
        self.pageNumber = self.pageNumber + 1
        self.getAirDataFromServer(isleft: true)
    }
    func rightBtnClicked()
    {
        self.pageNumber = self.pageNumber - 1
        self.getAirDataFromServer(isleft: false)
    }
    
}

extension DocQualitaViewController : AirQualitaNewSec2CellDelegate{
    func buttonTapped(tag: Int) {
        selectedButton = tag
        self.tableView.reloadData()
    }
    
    
}
