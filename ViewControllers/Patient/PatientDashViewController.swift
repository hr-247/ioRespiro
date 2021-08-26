//
//  PatientDashViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 14/12/2020.
//

import UIKit
import BadgeSwift

class PatientDashViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //variables
    var estimateWidth = 160.0
    var cellMarginSize = 1.0
    var notificationArr = [NotificationModal]()
    var badgeCount = Int()
    var imgWidthArr : [CGFloat] = [40,57,62,56,62,46]
    var imgHeightArr : [CGFloat] = [55,57,51,56,62,67]
    
    
    //outltes
    @IBOutlet weak var collectionView: UICollectionView!
    //    @IBOutlet weak var topHeaderCons: NSLayoutConstraint!
    //    @IBOutlet weak var headingLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  self.navigationController?.setNavigationBarHidden(true, animated: true)
        commonNavigationBar(title: "Dashboard", controller: Constant.Controllers.patientDashboard, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "\(self.badgeCount)")
        collectionViewProperty()
        //     headingLblUI()
        setupGridView()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //getNotificationListApi()
        getCurrentLocation()

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
    
    func getCurrentLocation(){
        if AppUtils.AppDelegate().isNetworkAvailable == false
        {
            Utils.stopLoading()
            AppUtils.showToast(message: Constant.Msg.offlineMsg)
            return
        }else{
        Utils.sharedInstance.initLocationManager()
            Utils.sharedInstance.locationHandler = { (loc, err) in
                
                guard let location = loc
                    else {
                        Utils.authorizeLocationCheck(vc: self)
                        return
                }
                
                print("location",location)
                
                self.airQualityDetailsApi(lat: location.coordinate.latitude, long: location.coordinate.longitude)
                
               
                
             }
        }
    }
    
    
    
    func collectionViewProperty(){
        
        collectionView.register(UINib(nibName: "PatientDashCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PatientDashCollectionViewCell")
        collectionView.register(UINib(nibName: "PatientDashSec1CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PatientDashSec1CollectionViewCell")
        //set delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    func setupGridView()
    {
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        //        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        
    }
    
    
    
    
}
extension PatientDashViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }else{
            return ClassConstants.imgArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientDashSec1CollectionViewCell", for: indexPath) as! PatientDashSec1CollectionViewCell
            cell.cellImg.image = UIImage(named: "bothImg")
            cell.topMarginView.isHidden = true
            cell.bottomMarginView.backgroundColor = UIColor.patientThemeColor
            cell.labelProperty(color: UIColor.patientThemeColor)
            cell.delegate = self
            
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientDashCollectionViewCell", for: indexPath) as! PatientDashCollectionViewCell
            
            cell.itemImg.image = UIImage(named: ClassConstants.imgArr[indexPath.item])
            cell.itemName.text = ClassConstants.txtArr[indexPath.item]
            cell.labelProperty(color: UIColor.patientThemeColor)
            cell.setMarginProperty(color: UIColor.patientThemeColor)
            
            cell.bottomMarginView.isHidden = false
            
            
            if indexPath.item % 2 == 0 {
                cell.rightMarginView.isHidden = false
                cell.bottomLeadingCons.constant = 20
            }
            if indexPath.item % 2 == 1 {
                cell.rightMarginView.isHidden = true
                cell.bottomTrailingCons.constant = 20
            }
            
            if indexPath.item  > 3 {
                cell.bottomMarginView.isHidden = true
                
            }
            
            resizeUI(view: cell.itemImg, width: imgWidthArr[indexPath.item], height: imgHeightArr[indexPath.item])
            
            return cell
        }
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1
        {
            if indexPath.item == 0{

                self.tabBarController?.selectedIndex = 1
                
            }
            else if indexPath.item == 1{
                
                //     self.tabBarController?.selectedIndex = 1
                let vc = Constant.Controllers.video.get() as! VideoViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.item == 2{
                
                let vc = Constant.Controllers.educazione.get() as! EduViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
             //   self.tabBarController?.selectedIndex = 1
            }
            else if indexPath.item == 3{
                
                let vc = Constant.Controllers.PPromemoria.get() as! PatientPromemoriaViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
             //   self.tabBarController?.selectedIndex = 2
            }
            else if indexPath.item == 4{
                
//                let vc = Constant.Controllers.patientQualita.get() as! QualitaViewController
//                self.navigationController?.pushViewController(vc, animated: true)
                
                self.tabBarController?.selectedIndex = 2
            }
            else{
                
//                let vc = Constant.Controllers.patientStato.get() as! PatientStatoSaluteViewController
//                self.navigationController?.pushViewController(vc, animated: true)
                
                self.tabBarController?.selectedIndex = 3
            }
        }
    }
    
    
}
extension PatientDashViewController : UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0
        {
            
            
            return CGSize(width: CGFloat((collectionView.frame.size.width) - 20), height: 98)
        }else{
            //      let width = self.CalculateWidth()
            
            return CGSize(width: (self.view.frame.size.width - 41) / 2, height: (self.view.frame.size.width - 41) / 2)
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    
    func CalculateWidth() -> CGFloat
    {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        let margin = CGFloat(cellMarginSize * 2)
        
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
        
    }
}

extension PatientDashViewController : DashSec1CollViewCellDelegate
{
    func profileBtnActn() {
        let vc = Constant.Controllers.pProfileModify.get() as! PatientProfileModifyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

extension PatientDashViewController
{
    //Get Notification count Api
    func getNotificationListApi()
    {
        
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Notification_List, modalName: [NotificationModal].self) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil
            {
                self.notificationArr = modal!
            }
            
            self.badgeCount = self.notificationArr.count
            
            AppUtils.AppDelegate().badgeCount = "\(self.badgeCount)"
            
            self.commonNavigationBar(title: "Dashboard", controller: Constant.Controllers.patientDashboard, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "\(self.badgeCount)")
            
        }
        
    }
    
    //Save current location's air quality
    func airQualityDetailsApi(lat: Double, long: Double)
    {
        guard let uId = Utils.getStringForKey(ClassConstants.Datakeys.userId)
        else{
            return
        }
       
        
        let request : [String:Any] = [ "userId": uId,
                                       "locations": [lat,long]
                                    ]
        
        print("request -- ", request)
        Service.sharedInstance.postJSONRequest(Url: APIManager.APIs.addAirQualityDetails, modalName: SubmitTest.self, parameter: request) { (modal, error) in
            
            if modal?.status == 1{
               // AppUtils.showToast(message: "data saved")
            }
            
            
        }
        
    }
}
