//
//  DoctorDashboardViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 15/12/2020.
//

import UIKit

class DoctorDashboardViewController: UIViewController{
    
    
    //variables
    var estimateWidth = 160.0
    var cellMarginSize = 1.0
    var nameLbl = ""
    var batchNumber = ""
    var testArr = [TestAssessmentModal]()
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Paziente", controller: Constant.Controllers.doctorDash, color: UIColor.docThemeColor, shadowColor: .docShadowColor, icon: "home", badgeCount: "")
        headingLblUI()
        collectionViewProperty()
        setupGridView()
        //getCurrentLocation()
        
    }
    
 

    func headingLblUI()
    {
        
      //  topHeadingCons.constant = 0.04*UIScreen.main.bounds.height;
        headingLbl.text = batchNumber
        headingLbl.textColor = UIColor.docThemeColor
        headingLbl.font = UIFont(name: AppFontName.ralewayBold, size: 20)
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
        flow.minimumInteritemSpacing = CGFloat(0)
        flow.minimumLineSpacing = CGFloat(0)
        
    }
    

    

}
extension DoctorDashboardViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1
        {
            return 2
        }else{
            return 1

//            return ClassConstants.docImgArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0
        {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientDashSec1CollectionViewCell", for: indexPath) as! PatientDashSec1CollectionViewCell
            cell.cellImg.image = UIImage(named: "docBothImg")
            cell.cellLbl.text = "PROFILO"
            cell.cellLbl.font = UIFont.appHeadingBody
            cell.labelProperty(color: UIColor.docThemeColor)
            cell.topMarginView.isHidden  = true
            cell.bottomMarginView.backgroundColor = UIColor.docThemeColor
            cell.delegate = self
            return cell
            
        }else if indexPath.section == 2
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientDashCollectionViewCell", for: indexPath) as! PatientDashCollectionViewCell
        
        cell.itemImg.image = UIImage(named: "docQualita")
        cell.itemName.text = "QUALITÀ DELL’ARIA"
        cell.labelProperty(color: UIColor.docThemeColor)
        cell.setMarginProperty(color: UIColor.docThemeColor)
            cell.bottomMarginView.isHidden = true
            cell.rightMarginView.isHidden = true
            return cell
        }
        else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientDashCollectionViewCell", for: indexPath) as! PatientDashCollectionViewCell
        
        cell.itemImg.image = UIImage(named: ClassConstants.docImgArr[indexPath.item])
        cell.itemName.text = ClassConstants.docTxtArr[indexPath.item]
        cell.labelProperty(color: UIColor.docThemeColor)
        cell.setMarginProperty(color: UIColor.docThemeColor)
            
            cell.rightMarginView.isHidden = true

            if indexPath.item % 2 == 0 {
                cell.rightMarginView.isHidden = false
            }
            
            
            
            return cell
        }
        
       
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1
        {
            if indexPath.item == 0{
               
                    let vc = Constant.Controllers.assignatiTest.get() as! AssignatiTestViewController
                    vc.batchNo = self.batchNumber
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            
            if indexPath.item == 1{
                
                let vc = Constant.Controllers.docPromemoria.get() as! DocPromemoriaViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
            if indexPath.section == 2{
                
                let vc = Constant.Controllers.docQualita.get() as! DocQualitaViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        
    }
   
    
    
}
extension DoctorDashboardViewController : UICollectionViewDelegateFlowLayout
{
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0
        {
           
            
            return CGSize(width: CGFloat((collectionView.frame.size.width) - 20), height: 98)
        }else{
            let width = self.CalculateWidth()
            
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
extension DoctorDashboardViewController: DashSec1CollViewCellDelegate
{
    func profileBtnActn() {
        let vc = Constant.Controllers.profile.get() as! ProfileViewController
        vc.batchHeading   = self.batchNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileImgBtnActn() {
        let vc = Constant.Controllers.docLogout.get() as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
       // print("clicked")
    }
    
    
}


    

    
