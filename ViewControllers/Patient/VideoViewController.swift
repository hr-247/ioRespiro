//
//  VideoViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 15/12/2020.
//

import UIKit

class VideoViewController: UIViewController {
    
    //variables
    
    
    //outlets
    @IBOutlet weak var topHeaderCons: NSLayoutConstraint!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var videoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: "Video esercizi", controller: Constant.Controllers.video, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
     //   headingUI()
        tableViewProperty()
       // addBackButton()
    }
    
//    func headingUI(){
//        topHeaderCons.constant = 0.04*UIScreen.main.bounds.height
//        headingLbl.text = "VIDEO ESERCIZI"
//        headingLbl.textColor = UIColor.headingColor
//        headingLbl.font = UIFont.appTitle2
//
//    }
    
    func tableViewProperty(){
        videoTableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        
    }
    

   
}
extension VideoViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClassConstants.videoArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // Make the background color show through
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        cell.videoImgView.image = UIImage(named: ClassConstants.videoArr[indexPath.row])
        cell.lbl.text = ClassConstants.lblArr[indexPath.row]
        cell.lblUI()
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = Constant.Controllers.ambient1.get() as! Ambiente1ViewController
            vc.navtitle = "Ambiente 1"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if  indexPath.row == 1{
            let vc = Constant.Controllers.ambient1.get() as! Ambiente1ViewController
            vc.navtitle = "Ambiente 2"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = Constant.Controllers.ambient1.get() as! Ambiente1ViewController
            vc.navtitle = "Ambiente 3"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
