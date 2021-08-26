//
//  UIVCExtension.swift
//  IoRespiro2019
//
//  Created by sanganan on 07/12/2020.
//

import UIKit
import BadgeSwift
import AVKit
import AVFoundation
import HCVimeoVideoExtractor
import SafariServices


extension UIViewController : UITextFieldDelegate  {
    
    func commonNavigationBar(title:String, controller:Constant.Controllers, color:UIColor, shadowColor:UIColor, icon:String, badgeCount:String)
    {
        self.view.backgroundColor = UIColor.appBackgroundColor
        navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = shadowColor.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        switch (controller){
        case .splash,.landingPage:
            
            let button2 = UIButton(type: .custom)
            button2.setImage(UIImage(named: "ioRespiro"),for: .normal)
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            
            self.navigationItem.leftBarButtonItem  = barButtonItem2
            break
            
        case .customerType :
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "back") , for: .normal)
            button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            
            let button2 = UIButton(type: .custom)
            button2.setImage(UIImage(named: "ioRespiro"),for: .normal)
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            
            self.navigationItem.leftBarButtonItems  = [barButtonItem, barButtonItem2]
            break
            
        case .docLogin,.patientLogin,.forgetPass,.patientForgetPass,.docDashTab:
            break
            
        case .patientRegistration,.docRegistration:
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "back") , for: .normal)
            button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            
            let button2 = UIButton(type: .custom)
            button2.setTitle(title, for: .normal)
            button2.titleLabel?.font = UIFont.appTitle2
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            
            self.navigationItem.leftBarButtonItems  = [barButtonItem, barButtonItem2]
            break
            
        case .doctorDash:
            
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "back") , for: .normal)
            button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            
            let button2 = UIButton(type: .custom)
            button2.setTitle(title, for: .normal)
            button2.titleLabel?.font = UIFont.appTitle2
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            
            self.navigationItem.leftBarButtonItems  = [barButtonItem, barButtonItem2]
            
            let button3 = UIButton(type: .custom)
            button3.setImage(UIImage(named: "docBell"), for: .normal)
            button3.addTarget(self, action: #selector(notificationBtnClickd), for: .touchUpInside)
            button3.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button3.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem3 = UIBarButtonItem(customView: button3)
            
            let button4 = UIButton(type: .custom)
            button4.setImage(UIImage(named: "logOutBtn"), for: .normal)
            button4.addTarget(self, action: #selector(alertLogout), for: .touchUpInside)
            button4.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button4.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem4 = UIBarButtonItem(customView: button4)
            
            self.navigationItem.rightBarButtonItems  = [barButtonItem3,barButtonItem4]
            break
            
            
        case .profile,.stato,.addStato,.docTest,.docPromemoria,.docLogout,.docQualita,.docNoTstAssgnd,.assegnaTest,.assignatiTest,.freqList:
            
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "back") , for: .normal)
            button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            
            let button2 = UIButton(type: .custom)
            button2.setTitle(title, for: .normal)
            button2.titleLabel?.font = UIFont.appTitle2
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            
            self.navigationItem.leftBarButtonItems  = [barButtonItem, barButtonItem2]
            
            let button3 = UIButton(type: .custom)
            button3.setImage(UIImage(named: "docBell"), for: .normal)
            button3.addTarget(self, action: #selector(notificationBtnClickd), for: .touchUpInside)
            button3.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button3.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem3 = UIBarButtonItem(customView: button3)
            
            let button4 = UIButton(type: .custom)
            button4.setImage(UIImage(named: "Group-55636"), for: .normal)
            button4.addTarget(self, action: #selector(homeBtnClickd), for: .touchUpInside)
            button4.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button4.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem4 = UIBarButtonItem(customView: button4)
            
            self.navigationItem.rightBarButtonItems  = [barButtonItem3,barButtonItem4]
            
            break
            
            
        case .patientDashboard:
            let button2 = UIButton(type: .custom)
            button2.setTitle(title, for: .normal)
            button2.titleLabel?.font = UIFont.appTitle2
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            self.navigationItem.leftBarButtonItems  = [barButtonItem2]
            
            addNotificationIcon(icon: icon)
            break
            
            
        case .docDashboard, .home1:
            let button2 = UIButton(type: .custom)
            button2.setTitle(title, for: .normal)
            button2.titleLabel?.font = UIFont.appTitle2
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            
            self.navigationItem.leftBarButtonItems  = [barButtonItem2]
           // addNotificationIcon(icon: icon)
            
            let button3 = UIButton(type: .custom)
            button3.setImage(UIImage(named: "docBell"), for: .normal)
            button3.addTarget(self, action: #selector(notificationBtnClickd), for: .touchUpInside)
            button3.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button3.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem3 = UIBarButtonItem(customView: button3)
            self.navigationItem.rightBarButtonItem  = barButtonItem3

            break
            
        case .patientStato,.patientQualita,.patientAssignati :
            //            let button = UIButton(type: .custom)
            //            button.setImage(#imageLiteral(resourceName: "back") , for: .normal)
            //            button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
            //            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            //            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            //            let barButtonItem = UIBarButtonItem(customView: button)
            
            let button2 = UIButton(type: .custom)
            button2.setTitle(title, for: .normal)
            button2.titleLabel?.font = UIFont.appTitle2
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            
            self.navigationItem.leftBarButtonItems  = [barButtonItem2]
            addNotificationIcon(icon: icon)

            break
        case .test, .testTai, .testSampre, .ambient1, .ambient2, .ambient3,.addPatientPromemoria,.pProfileModify,.patientProfile,.eduDetail,.storicoList,.video,.archiveTestList,.wearable,.notification,.educazione, .PPromemoria,.rangeChart:
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "back") , for: .normal)
            button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            
            let button2 = UIButton(type: .custom)
            button2.setTitle(title, for: .normal)
            button2.titleLabel?.font = UIFont.appTitle2
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            
            self.navigationItem.leftBarButtonItems  = [barButtonItem, barButtonItem2]
            
            addNotificationIcon(icon: icon)

            
            break
            
        case .menu:
            addNotificationIcon(icon: icon)

            break
            
            
            
        case .home3:
            
            let button2 = UIButton(type: .custom)
            button2.setImage(UIImage(named: "ioRespiro"),for: .normal)
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            self.navigationItem.leftBarButtonItem  = barButtonItem2
            
            let button3 = UIButton(type: .custom)
            button3.setImage(UIImage(named: "logOutBtn"), for: .normal)
            button3.addTarget(self, action: #selector(alertLogout), for: .touchUpInside)
            button3.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button3.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem3 = UIBarButtonItem(customView: button3)
            
            self.navigationItem.rightBarButtonItem = barButtonItem3
            
            break
            
        case .progressRing:
            
            break
            
        }
    }
    
    func addNotificationIcon(icon:String)
    {
        let button3 = UIButton(type: .custom)
        button3.setImage(UIImage(named: icon), for: .normal)
        button3.addTarget(self, action: #selector(notificationBtnClickd), for: .touchUpInside)
        button3.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button3.widthAnchor.constraint(equalToConstant: 25).isActive = true
        let barButtonItem3 = UIBarButtonItem(customView: button3)
        
        let badge = BadgeSwift(frame: CGRect(x: 12, y: -8, width: 22.5, height: 22.5))
        
        badge.font = UIFont(name: AppFontName.regular, size: 11)
        badge.textColor = UIColor.patientThemeColor
        badge.textAlignment = .center
        badge.badgeColor = UIColor.white
        badge.layer.cornerRadius =  badge.frame.width/2
        
        let badgeCount = AppUtils.AppDelegate().badgeCount
        
        
        
        badge.text = badgeCount
        button3.addSubview(badge)
        
        if Int(badgeCount)! > 0
        {
            badge.isHidden = false
        }else{
            badge.isHidden = true
        }
        
        self.navigationItem.rightBarButtonItem  = barButtonItem3
    }
    
    
    
    // MARK:- Email validation
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z][A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}$"
        let trimmedString = testStr.trimmingCharacters(in: .whitespaces)
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: trimmedString)
        return result
        
    }
    
    // MARK:- username Validation
    func isValidUsrName(testStr:String) -> Bool {
        
        guard testStr.count > 2, testStr.count < 18 else { return false }
        
        return true
    }
    
    //MARK:- Mobile Number Validation
    func isValidMblNum(testStr:String) -> Bool {
        
        print("validate MblNum: \(testStr)")
        let mblNumRegEx = "^\\d{10}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", mblNumRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        
    }
    
    
    func addBackButton()
    {
        let guide = self.view.safeAreaLayoutGuide
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "back") , for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 2).isActive = true
        button.topAnchor.constraint(equalTo: guide.topAnchor, constant: 5).isActive = true
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.widthAnchor.constraint(equalToConstant: 42).isActive = true
        
        
    }
    
    @objc func backButtonClicked()
    {
        self.navigationController?.popViewController(animated: true);
    }
    
    @objc func notificationBtnClickd()
    {
        
        
    }
    
    @objc func homeBtnClickd()
    {
//        self.navigationController?.popToRootViewController(animated: true)
        
        
        guard let array = self.navigationController?.viewControllers else {return}
        
        for item in array
        {
            if item is DoctorDashboardViewController
            {
                self.navigationController?.popToViewController(item, animated: true)
                break;
            }
            
        }
        
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func clearNavigationStack()
    {
        
        guard let navController = self.navigationController else {return}
        
        let navigationArray = navController.viewControllers
        
        let lastVC = navigationArray.last
        
        self.navigationController?.viewControllers = [lastVC!]
        
        
        
    }
    
    func removeLastFromNavigationStack()
    {
        guard let navController = self.navigationController else {return}
        var navigationArray = navController.viewControllers
        navigationArray.remove(at: navigationArray.count - 2)
        
        self.navigationController?.viewControllers = navigationArray
        
        
    }
    
    @objc func alertLogout()
    {
        let alertController = UIAlertController(title: "Disconnettersi", message: "Conferma logout.", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.logOut()
        }
        
        let cancelAction = UIAlertAction(title: "Annulla", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancelled")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func logOut()
    {
        
        Utils.deleteValueFor(key: ClassConstants.Datakeys.token)
        Utils.deleteValueFor(key: ClassConstants.Datakeys.type)
        Utils.deleteValueFor(key: ClassConstants.Datakeys.userId)
        Utils.deleteValueFor(key: ClassConstants.Datakeys.email)

        AppUtils.AppDelegate().badgeCount = "0"
        let vc = Constant.Controllers.landingPage.get() as! LandingPageViewController
        
        if self.tabBarController?.navigationController != nil
        {
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        }else
        {
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        
        self.clearNavigationStack()
        
    }
    
    
    func playVideo(str : String)
    {
        
        
        if str.contains("/video/") {
            // public video
            
            let url = URL(string: str)!
            
            HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
                if let err = error {
                    print("Error = \(err.localizedDescription)")
                    return
                }
                
                guard let vid = video else {
                    print("Invalid video object")
                    return
                }
                
                print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")
                 
                
                DispatchQueue.main.async {
                    if let videoURL = vid.videoURL[ .Quality720p] {
                        let player = AVPlayer(url: videoURL)
                        let playerController = AVPlayerViewController()
                        playerController.player = player
                        playerController.allowsPictureInPicturePlayback = true
                        self.present(playerController, animated: true) {
                            player.play()
                        }
                    }
                }
               
            })
            
            
            return
            
            
        }
        
        
        
        
        let array = str.components(separatedBy: "/")
        
        if array.count < 2 {
            return
        }
        
        let strID = array[array.count - 2] as? String
        
        if let id = strID  {
        
        HCVimeoVideoExtractor.fetchVideoURLFrom(id: id, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            if let err = error {
                print("Error = \(err.localizedDescription)")
                return
            }
            
            guard let vid = video else {
                print("Invalid video object")
                return
            }
            
            print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")
             
            
            DispatchQueue.main.async {
                if let videoURL = vid.videoURL[ .Quality720p] {
                    let player = AVPlayer(url: videoURL)
                    let playerController = AVPlayerViewController()
                    playerController.player = player
                    playerController.allowsPictureInPicturePlayback = true
                    self.present(playerController, animated: true) {
                        player.play()
                    }
                }
            }
           
        })
        
        }else
        {
            AppUtils.showToast(message: Constant.Msg.invalidVideoPath)
            
        }

       
  }
    
    func resizeUI(view: UIImageView,width: CGFloat, height: CGFloat)
    {
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
        
    }
    
    
  func openTnC()
  {
      if let url = URL(string: "https://www.iubenda.com/privacy-policy/60468201") {
              let config = SFSafariViewController.Configuration()
              config.entersReaderIfAvailable = true

              let vc = SFSafariViewController(url: url, configuration: config)
              present(vc, animated: true)
  }
  }
    
    //Navigation Title change doctor side
    func navTitleUI(title:String)
    {
        self.view.backgroundColor = UIColor.appBackgroundColor
        navigationController?.navigationBar.barTintColor = .docThemeColor
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.docShadowColor.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "back") , for: .normal)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        let barButtonItem = UIBarButtonItem(customView: button)
        
        let button2 = UIButton(type: .custom)
        button2.setTitle(title, for: .normal)
        button2.titleLabel?.font = UIFont(name: AppFontName.regular, size: 16)
        let barButtonItem2 = UIBarButtonItem(customView: button2)
        
        self.navigationItem.leftBarButtonItems  = [barButtonItem, barButtonItem2]
        
        let button3 = UIButton(type: .custom)
        button3.setImage(UIImage(named: "docBell"), for: .normal)
        button3.addTarget(self, action: #selector(notificationBtnClickd), for: .touchUpInside)
        button3.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button3.widthAnchor.constraint(equalToConstant: 25).isActive = true
        let barButtonItem3 = UIBarButtonItem(customView: button3)
        
        let button4 = UIButton(type: .custom)
        button4.setImage(UIImage(named: "Group-55636"), for: .normal)
        button4.addTarget(self, action: #selector(homeBtnClickd), for: .touchUpInside)
        button4.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button4.widthAnchor.constraint(equalToConstant: 25).isActive = true
        let barButtonItem4 = UIBarButtonItem(customView: button4)
        
        self.navigationItem.rightBarButtonItems  = [barButtonItem3,barButtonItem4]
    }
    
    
    //Navigation Title change patient side
    func patNavTitleUI(title:String)
    {
        self.view.backgroundColor = UIColor.appBackgroundColor
        navigationController?.navigationBar.barTintColor = .statusBarColor
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.patientShadowColor.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "back") , for: .normal)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        let barButtonItem = UIBarButtonItem(customView: button)
        
        let button2 = UIButton(type: .custom)
        button2.setTitle(title, for: .normal)
        button2.titleLabel?.font = UIFont(name: AppFontName.regular, size: 16)
        let barButtonItem2 = UIBarButtonItem(customView: button2)
        
        self.navigationItem.leftBarButtonItems  = [barButtonItem, barButtonItem2]
        
        addNotificationIcon(icon: "bellIcon")

        
    }
    
}
