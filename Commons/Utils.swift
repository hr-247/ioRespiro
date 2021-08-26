//
//  Utils.swift
//  IoRespiro2019
//
//  Created by Sanganan on 18/11/20.
//

import UIKit
import SwiftSpinner
import CoreLocation


class Utils: NSObject, CLLocationManagerDelegate {
    
    var locationHandler : (CLLocation?, Error?) -> Void =
    {
        (loc,err) in
    }
    
    var locationManager: CLLocationManager!
    static var sharedInstance = Utils()
    
    
    static func setAppFlow(window : UIWindow)
    {
        var landingPage = Constant.Controllers.get(.splash)()
        window.makeKeyAndVisible()
        if let type = Utils.getStringForKey(ClassConstants.Datakeys.type)
        {
            if type == ClassConstants.UserType.patient {
                landingPage =  Constant.Controllers.patientDashboard.get() as! PatientDashboardViewController
            }else
            {
//                landingPage =  Constant.Controllers.docDashTab.get() as! DocDashTabBarViewController
                
                AppUtils.AppDelegate().getDoctorDetails()
                
                return
                
                landingPage =  Constant.Controllers.home3.get() as! Home3ViewController

            }
        }
        let nav = UINavigationController.init(rootViewController: landingPage)
      //  nav.isNavigationBarHidden = true
        window.rootViewController = nav
        
    }
    
    //MARK: LoadingIndicator
    static func startLoadingWithTitle(_ title : String)
    {
        SwiftSpinner.shared.outerColor = UIColor.patientThemeColor
        SwiftSpinner.shared.innerColor = UIColor.docThemeColor
        SwiftSpinner.show(title)

    }
    
    static func stopLoading()
    {
        SwiftSpinner.hide()
    }
    
    //MARK: LocallyDataSaving
    static func saveStringForKey(key : String, value : String )
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
        
    }
    
    static func deleteValueFor(key : String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
        
    }
    static func getStringForKey(_ key : String) -> String?
    {
        let defaults = UserDefaults.standard
        guard let value = defaults.value(forKey: key) as? String else {
            return nil
        }
        
        return value
    }
    
    // Location Manager helper stuff
       func initLocationManager() {
           
           locationManager = CLLocationManager()
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestAlwaysAuthorization()
           locationManager.startUpdatingLocation()
       }
       
       // Location Manager Delegate stuff
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("errorOfLocation:: \(error.localizedDescription)")
           locationHandler(nil,error)
       }
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse {
               locationManager.requestLocation()
           }
           else if status == .denied{
               
           }
           else if status == .notDetermined{
             
           }
           else if status == .restricted{
             
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           
           if locations.first != nil {
               
               locationHandler(locations.first,nil)
           }
           locationManager.stopUpdatingLocation();
       }
       
       static func authorizeLocationCheck(vc:UIViewController){
           
              if CLLocationManager.locationServicesEnabled() {
               
                  switch CLLocationManager.authorizationStatus() {
                   
                  case .notDetermined, .restricted, .denied:
                   let alertController = UIAlertController(title: "Permesso di Loation", message: "Concedi l'autorizzazione alla posizione.", preferredStyle: UIAlertController.Style.alert)
                      
                      let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(cAlertAction) in
                          //Redirect to Settings app
                          UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                      })
                      
                      let cancelAction = UIAlertAction(title: "Annulla", style: UIAlertAction.Style.cancel)
                      alertController.addAction(cancelAction)
                      
                      alertController.addAction(okAction)
                      
                      vc.present(alertController, animated: true, completion: nil)
                  case .authorizedAlways, .authorizedWhenInUse:
                      print("Access")
                  @unknown default:
                      break
                  }
              } else {
     //             print("Location services are not enabled")
               
                AppUtils.showToast(message: Constant.Msg.locServiceNotEnabled)
         
              }
          }
    
    
    
    
    
    static func handleMultiple(modal : ProfileModal) -> String
    {
        
        guard let resp = modal.altre_respiratorie else {return ""}
        
        switch resp {
            case .string(let text):
              
               
                    let data = text.data(using: .utf8)!
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String]
                        {
                           print(json) // use the json here
                            return json.joined(separator: ",")
                            
                        } else {
                            return ""
                        }
                    } catch let error as NSError {
                        return text
                    }
                
                
                
                
            case .array(let arr):
                
                return arr.joined(separator: ",")
                
       
        }
        
    }
    
    

}
