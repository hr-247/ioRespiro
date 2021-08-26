//
//  ProgressRingViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 05/03/2021.
//

import UIKit
import CoreLocation

class ProgressRingViewController: UIViewController {
    
    var pollutantArr = [String]()
  //  var nameArr = ["co","p","pm10","pm2.5","t","w","dew","h","no2","o3"]
    var nameArr = [String]()
    var location : locationModal?
    var date = ""
    var lat : Double?
    var long : Double?
    let ceo: CLGeocoder = CLGeocoder()
    var cityName = ""
    var stationName = ""
    var frmDrSide = false
    
    
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionProperty()
        setupGridView()
     //   pollutantArr = pollutantArr.filter { $0 != "0" }
        
        guard let lat = location?.x,
        let long = location?.y
        else{
          return
        }
        getRegion(lat: lat, long: long)
    }
    
    func collectionProperty()
    {
        collectionView.register(UINib(nibName: "ProgressRingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProgressRingCollectionViewCell")
    collectionView.register(UINib(nibName: "ProgressRingSec1CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProgressRingSec1CollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    func setupGridView()
    {
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(0)
        flow.minimumLineSpacing = CGFloat(0)
        
    }
    
    @IBAction func crossBtnActn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension ProgressRingViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }else{
        return pollutantArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressRingSec1CollectionViewCell", for: indexPath) as! ProgressRingSec1CollectionViewCell
            
            if self.frmDrSide == true{
                cell.lblUI(txt: date, color: .docThemeColor)
                cell.locLblUI(txt: self.cityName, color: .docThemeColor)
                cell.stationLblUI(txt: "(Stazione di : \(self.stationName))", color: .docThemeColor)
                
            }else{
            
            cell.lblUI(txt: date, color: .patientThemeColor)
            cell.locLblUI(txt: "\(self.cityName)", color: .patientThemeColor)
                cell.stationLblUI(txt: "(Stazione di : \(self.stationName))", color: .patientThemeColor)
            }
     
            
            return cell
            
            
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressRingCollectionViewCell", for: indexPath) as! ProgressRingCollectionViewCell
            
//            if pollutantArr[indexPath.row] == "0" {
//
//                cell.contentView.isHidden = true
//                cell.layer.borderColor = UIColor.white.cgColor
//            }
//            else {
//                cell.contentView.isHidden = false
//                cell.layer.borderColor = UIColor.black.cgColor //Set Default color here
//            }
            
            if self.frmDrSide == true{
                cell.lblUI(txt: nameArr[indexPath.item], color: .docThemeColor)
                cell.ringViewUI(color: .docThemeColor, data: pollutantArr[indexPath.item])
                
            }else{
                cell.lblUI(txt: nameArr[indexPath.item], color: .patientThemeColor)
                cell.ringViewUI(color: .patientThemeColor, data: pollutantArr[indexPath.item])
                
            }
        
        
        
        
        return cell
        }
    }
    
    
}

extension ProgressRingViewController : UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //    let width = self.CalculateWidth()
        
        //        return CGSize(width: (self.view.frame.size.width - 61) / 2, height: (self.view.frame.size.width - 61) / 2)
        
        if indexPath.section == 0{
            return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width)
        }else{
//        if pollutantArr[indexPath.row] == "0" {
//            return CGSize(width: 0, height: 0)
//        }else{
        
        return CGSize(width: (self.view.frame.size.width - 61) / 2, height: (self.view.frame.size.width - 61) / 2)
       // }
        }
        
        
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

extension ProgressRingViewController{
    
    func getRegion(lat: Double,long: Double){
        let location = CLLocation(latitude: lat, longitude: long)
        ceo.reverseGeocodeLocation(location, completionHandler:
                    {(placemark, error) in
            if let error = error as? CLError {
                print("CLError:", error)
                return
            } else if let placemark = placemark?.first {
                // you should always update your UI in the main thread
                DispatchQueue.main.async {

//                    self.addrLine1TF.text  = placemark.thoroughfare ?? ""
//                    self.addrLine2TF.text = placemark.subThoroughfare ?? ""
                    self.cityName = placemark.locality ?? ""
                    self.collectionView.reloadData()

//                    self.stateTF.text = placemark.administrativeArea ?? ""
//                    self.zipTF.text = placemark.postalCode ?? ""
//                    self.countryTF.text =  placemark.country ?? ""

                }
            }
        })
    }
}

