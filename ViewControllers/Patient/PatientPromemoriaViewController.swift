//
//  PatientPromemoriaViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 17/12/2020.
//

import UIKit

class PatientPromemoriaViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Promemoria", controller: Constant.Controllers.PPromemoria, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
      //  headingLblUI()
        tableViewProperty()
        
    }
    func headingLblUI()
    {
        topHeadingCons.constant = 0.04*UIScreen.main.bounds.height
        headingLbl.text = "Promemoria"
        headingLbl.font = UIFont.appTitle2
        headingLbl.textColor = UIColor.headingColor
    }
    
    func tableViewProperty()
    {
        tableView.register(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "ReminderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
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

    
    @IBAction func plusBtnActn(_ sender: UIButton) {
    }
    
}
extension PatientPromemoriaViewController  : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTableViewCell", for: indexPath) as! ReminderTableViewCell
        cell.lbl1UI(txt: "Titolo")
        cell.lbl2UI(txt: "Data, ora")
        cell.switchUI(color: UIColor.patientThemeColor)
        if indexPath.row == 4 {
            cell.lineView.isHidden = true
        }
        
        return cell
        
    }
    
    
}
