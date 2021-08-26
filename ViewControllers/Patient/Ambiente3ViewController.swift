//
//  Ambiente3ViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 15/12/2020.
//

import UIKit
import AVKit

class Ambiente3ViewController: UIViewController {

    //outlets
    @IBOutlet weak var topHeaderCons: NSLayoutConstraint!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        commonNavigationBar(title: "Ambiente 3", controller: Constant.Controllers.ambient3, color: UIColor.statusBarColor, shadowColor: UIColor.patientShadowColor, icon: "bellIcon", badgeCount: "")
        collectionViewProperty()
        setupGridView()
        addBackButton()
        
    }
    func headingUI(){
        topHeaderCons.constant = 0.04*UIScreen.main.bounds.height
        headingLbl.text = "Ambiente 3"
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
extension Ambiente3ViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmbientCollectionViewCell", for: indexPath) as! AmbientCollectionViewCell
        cell.imgView.image = UIImage(named: "ambiente3Img")
        cell.playImg.image = UIImage(named: "videoImg")
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")!
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player

        present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    
    
}
extension Ambiente3ViewController : UICollectionViewDelegateFlowLayout
{
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            let width = self.CalculateWidth()
            
//        return CGSize(width: (self.view.frame.size.width - 61) / 2, height: (self.view.frame.size.width - 61) / 2)
        
        return CGSize(width: (self.view.frame.size.width - 61) / 2, height: (self.view.frame.size.width - 61) / 2)

        
            

        }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
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

