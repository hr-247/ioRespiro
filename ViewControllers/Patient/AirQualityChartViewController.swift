//
//  AirQualityChartViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 04/03/2021.
//

import UIKit

class AirQualityChartViewController: UIViewController {
    
    var rangeArr = ["0-50","51-100","101-150","151-200","201-300",">300"]
    var imgArr = ["rangeImg1","rangeImg2","rangeImg3","rangeImg4","rangeImg5","rangeImg6"]
    var colorArr : [UIColor] = [UIColor(red: 18/255, green: 254/255, blue: 1/255, alpha: 1),.airQualitaYellow,UIColor(red: 254/255, green: 120/255, blue: 1/255, alpha: 1),UIColor(red: 213/255, green: 0/255, blue: 0/255, alpha: 1),UIColor(red: 162/255, green: 13/255, blue: 94/255, alpha: 1),UIColor(red: 170/255, green: 0/255, blue: 0/255, alpha: 1)]
    var frmDrSide = false
    
    
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var headingLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if frmDrSide == true{
            commonNavigationBar(title: "Qualità Dell'aria", controller: Constant.Controllers.rangeChart, color: .docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        }else{

            commonNavigationBar(title: "Qualità Dell'aria", controller: Constant.Controllers.rangeChart, color: .statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")}
        tableViewProperty()
        addCrossButton()
        headingLblUI()
    }
    
    func headingLblUI(){
        headingLbl.text = "Tabella - AQI"
        headingLbl.font = .appTitle2
        if frmDrSide == true{
            headingLbl.textColor = .docShadowColor
        }else{
            headingLbl.textColor = .patientThemeColor
        }
    }
    
    func addCrossButton()
    {
        let guide = self.view.safeAreaLayoutGuide
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "close") , for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(crossButtonClicked), for: .touchUpInside)
        self.view.addSubview(button)
     //   button.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        button.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
        button.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    
    @objc func crossButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    

   func tableViewProperty()
   {
    tableView.register(UINib(nibName: "AIrQualityChartTableViewCell", bundle: nil), forCellReuseIdentifier: "AIrQualityChartTableViewCell")
    
    tableView.delegate = self
    tableView.dataSource = self
   }

}

extension AirQualityChartViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AIrQualityChartTableViewCell", for: indexPath) as! AIrQualityChartTableViewCell
        
        cell.dscLbl.text = ClassConstants.airQualityIndexArr[indexPath.row]
        cell.dscLbl.textColor = .black
        cell.imgVw.image = UIImage(named: imgArr[indexPath.row])
        cell.rangeLbl.text = rangeArr[indexPath.row]
        cell.rangeLbl.textColor = .black
        cell.mainVw.backgroundColor = colorArr[indexPath.row]
        cell.mainVw.layer.borderWidth = 1
        cell.mainVw.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1).cgColor
        cell.mainVw.roundCorners([.allCorners], radius: 15)
        cell.dscLbl.numberOfLines = 4
        cell.dscLbl.font = UIFont(name: AppFontName.medium, size: 10)
        cell.rangeLbl.font = UIFont(name: AppFontName.regular, size: 11)
        
        return cell
    }
    
    
}
