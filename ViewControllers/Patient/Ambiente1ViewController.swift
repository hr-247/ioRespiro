//
//  Ambiente1ViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 15/12/2020.
//

import UIKit


class Ambiente1ViewController: UIViewController {
    
    var videoArr = [VideoModal]()
    var navtitle = ""
    
   
    
    //outlets
    @IBOutlet weak var topHeaderCons: NSLayoutConstraint!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: navtitle, controller: Constant.Controllers.ambient1, color: UIColor.statusBarColor, shadowColor: UIColor.patientShadowColor, icon: "bellIcon", badgeCount: "")
       // headingUI()
        collectionViewProperty()
        setupGridView()
     //  addBackButton()
        getVideoListApi()
        
    }
    
   
    func headingUI(){
        topHeaderCons.constant = 0.04*UIScreen.main.bounds.height
        headingLbl.text = "Ambiente 1"
        headingLbl.textColor = UIColor.headingColor
        headingLbl.font = UIFont.appTitle2
        
    }
    
    func collectionViewProperty(){
        collectionView.register(UINib(nibName: "AmbientCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AmbientCollectionViewCell")
        
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
extension Ambiente1ViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmbientCollectionViewCell", for: indexPath) as! AmbientCollectionViewCell
        
        if navtitle == "Ambiente 1"{
        cell.imgView.image = UIImage(named: "Ambiente1Img")
        }
        if navtitle == "Ambiente 2"{
        cell.imgView.image = UIImage(named: "ambiente2Img")
        }
        if navtitle == "Ambiente 3"{
        cell.imgView.image = UIImage(named: "ambiente3Img")
        }
        cell.playImg.image = UIImage(named: "videoImg")
//
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let url = videoArr[indexPath.item].url
        {
          playVideo(str: url)
        
       }
        
        
        
       
  }
    
    
}
    

extension Ambiente1ViewController : UICollectionViewDelegateFlowLayout
{
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            let width = self.CalculateWidth()
            
//        return CGSize(width: (self.view.frame.size.width - 61) / 2, height: (self.view.frame.size.width - 61) / 2)
        
        return CGSize(width: (self.view.frame.size.width - 61) / 2, height: (self.view.frame.size.width - 61) / 2)


        }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
    }
    func CalculateWidth() -> CGFloat
    {
        let estimatedWidth = CGFloat(Constant.estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        let margin = CGFloat(Constant.cellMarginSize * 2)
        
        let width = (self.view.frame.size.width - CGFloat(Constant.cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
        
    }
}

extension Ambiente1ViewController{
    //Get Video Api
    func getVideoListApi()
    {
        
        Utils.startLoadingWithTitle("")
        Service.sharedInstance.getRequest(Url: APIManager.APIs.get_Video_List, modalName: [VideoModal].self) { (modal, error) in
            Utils.stopLoading()
            
            if modal != nil
            {
                for item in modal!{
                    
                    if item.type == self.navtitle{
                        self.videoArr.append(item)
                    }
                 
                }
            }
            
            self.collectionView.reloadData()
        
            }
        
    }
}

