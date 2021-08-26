//
//  EduViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 17/12/2020.
//

import UIKit

class EduViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //variables
    var eduData = [GetEducationModal]()
    
    
    //outlets
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: "Educazione", controller: Constant.Controllers.educazione, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        tableViewProperty()
    }
    override func viewWillAppear(_ animated: Bool) {
        getDataFromServer()
    }
    
    func headingUI(){
        topHeadingCons.constant = 0.04*UIScreen.main.bounds.height
        headingLbl.text = "Educazione"
        headingLbl.textColor = UIColor.headingColor
        headingLbl.font = UIFont.appTitle2
        
    }
    
    func tableViewProperty(){
        tableView.register(UINib(nibName: "EduTableViewCell", bundle: nil), forCellReuseIdentifier: "EduTableViewCell")
        
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
   

}
extension EduViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eduData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "EduTableViewCell", for: indexPath) as! EduTableViewCell
        guard let title = eduData[indexPath.row].data?.title , let body = eduData[indexPath.row].data?.content
              , let imageURL = eduData[indexPath.row].data?.image_url
//              let date = eduData[indexPath.row].created_at
        else{
            cell.lblUI(txt: "")
            cell.txtViewUI(txt: "")
            cell.viewUI(imageUrl: URL(string: ""))
            return cell}
        cell.lblUI(txt: title)
        cell.txtViewUI(txt: body)
        cell.viewUI(imageUrl: URL(string: imageURL))
        if let date = eduData[indexPath.row].created_at
        {
        cell.dateLblUI(date: date)
        }else{
            cell.dateLblUI(date: "")
        }
        cell.bottomLbl.text = "Leggi di più"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Constant.Controllers.eduDetail.get() as! EduDetailViewController
        vc.id = eduData[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension EduViewController
{
    func getDataFromServer()
    {
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Education, modalName: [GetEducationModal].self) { (modal, error) in
            Utils.stopLoading()
            
            guard let data =  modal
            else{
                AppUtils.showToast(message: Constant.Msg.errorMsg)
                return
            }
            self.eduData = data
            self.tableView.reloadData()
            
        }
    }
}
