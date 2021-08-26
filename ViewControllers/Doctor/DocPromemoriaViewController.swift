//
//  DocPromemoriaViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 16/12/2020.
//

import UIKit

class DocPromemoriaViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Promemoria", controller: Constant.Controllers.docPromemoria, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
      //  headingUI()
        tableViewProperty()
        
    }
    
    func headingUI(){
        topHeadingCons.constant = 0.04*UIScreen.main.bounds.height
        headingLbl.text = "Promemoria"
        headingLbl.textColor = UIColor.headingColor
        headingLbl.font = UIFont.appTitle2
        
    }
    
    func tableViewProperty(){
        tableView.register(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "ReminderTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

   

}

extension DocPromemoriaViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTableViewCell", for: indexPath) as! ReminderTableViewCell
        cell.lbl1UI(txt: "Titolo")
        cell.lbl2UI(txt: "Data, ora")
        cell.switchUI(color: UIColor.docThemeColor)
        if indexPath.row == 4 {
            cell.lineView.isHidden = true
        }
        return cell
    }
    
    
}
