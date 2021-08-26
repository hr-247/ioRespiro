//
//  FrequencyViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 08/02/2021.
//

import UIKit

class FrequencyViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var freqalbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonNavigationBar(title: "Assegna Test", controller: Constant.Controllers.freqList, color: UIColor.docThemeColor, shadowColor: UIColor.docShadowColor, icon: "", badgeCount: "")
        freqLblbUI()
        tableViewProperty()

    }
    
    func freqLblbUI()
    {
        freqalbl.text = "Frequenza"
        freqalbl.font = UIFont.appTitle
        freqalbl.textColor = UIColor.docShadowColor
    }
    
    func tableViewProperty()
    {
        tableView.register(UINib(nibName: "MenuHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuHeaderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    

}

extension FrequencyViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderTableViewCell", for: indexPath) as! MenuHeaderTableViewCell
        
     //   cell.headerLbl.text = freqArr[indexPath.row]
        cell.headerLbl.font = UIFont(name: AppFontName.ralewayMedium, size: 20)
        cell.headerLbl.textColor = UIColor.docShadowColor
        cell.midHeaderLbl.isHidden  = true
        
        
        return cell
        
    }
    
    
}
