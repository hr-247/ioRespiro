//
//  EduDetailViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 15/01/2021.
//

import UIKit

class EduDetailViewController: UIViewController {
    
    var id = Int()
    var eduDetail : GetEducationModal?
    
    //outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Educazione", controller: Constant.Controllers.eduDetail, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        tableViewProperty()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromServer(id: self.id)
     
    }
    
    func tableViewProperty()
    {
        tableView.register(UINib(nibName: "EduDeatilTableViewCell", bundle: nil), forCellReuseIdentifier: "EduDeatilTableViewCell")
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
   
 
}

extension EduDetailViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EduDeatilTableViewCell", for: indexPath) as! EduDeatilTableViewCell
        
        cell.viewUI(imageUrl: URL(string: self.eduDetail?.data?.image_url ?? ""))
        cell.lblUI(txt: self.eduDetail?.data?.title ?? "")
        cell.txtViewUI(txt: self.eduDetail?.data?.content ?? "")
        cell.dateLblUI(date: self.eduDetail?.created_at ?? "")
        
        
        return cell
    }
    
    
    
    
}

extension EduDetailViewController
{
    func getDataFromServer(id: Int)
    {
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Education_Detail + "\(id)", modalName: GetEducationModal.self) { (modal, error) in
            Utils.stopLoading()
            
            guard let data =  modal
            else  {
                AppUtils.showToast(message: Constant.Msg.errorMsg)
                return
            }
            self.eduDetail = data
            self.tableView.reloadData()
            
        }
    }
    
}
