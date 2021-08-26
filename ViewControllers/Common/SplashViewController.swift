//
//  SplashViewController.swift
//  IoRespiro2019
//
//  Created by Sanganan on 18/11/20.
//

import UIKit
import paper_onboarding

class SplashViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var forwardIcon: UIButton!
    @IBOutlet weak var splashView: PaperOnboarding!
    @IBOutlet weak var imageVw: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        commonNavigationBar(title: "", controller: Constant.Controllers.splash, color: UIColor.statusBarColor, shadowColor: .patientShadowColor, icon: "bellIcon", badgeCount: "")
        
    }
    

    @IBAction func forwardIconTapped(_ sender: Any) {
        
        
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


extension SplashViewController : PaperOnboardingDataSource, PaperOnboardingDelegate
{
    
    func onboardingItemsCount() -> Int {
        
        return ClassConstants.splashArray.count
        
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return ClassConstants.splashArray[index]

    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            forwardIcon.isHidden = false
        }else
        {
            forwardIcon.isHidden = true
        }
    }

    func onboardingPageItemColor(at index: Int) -> UIColor {
        
        return .darkGray
    }
    
    
}

