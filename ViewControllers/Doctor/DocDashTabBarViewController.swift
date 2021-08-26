//
//  DocDashTabBarViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 11/12/2020.
//

import UIKit

class DocDashTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var whBtn : Bool? = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
      clearNavigationStack()
        // Do any additional setup after loading the view.
        self.delegate = self
        customizeUITabBar()
    }
    

    func customizeUITabBar(){
        
        if whBtn == true{
            self.selectedIndex = 1;
        }else{
            self.selectedIndex = 0
        }
        
        
        var  bottomPadding : CGFloat = 0.0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = window?.safeAreaInsets.bottom ?? 0
        }
        
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: self.tabBar.frame.height + bottomPadding)
//        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.white , size: tabBarItemSize).resizableImage(withCapInsets: .init(top: 0, left: 0, bottom: bottomPadding, right: 0))
        
        
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.white , size: tabBarItemSize)
        

        // remove default border
        tabBar.frame.size.width = self.view.frame.width + 4
        tabBar.frame.origin.x = -2
        
        
        UITabBar.appearance().barTintColor = UIColor.docThemeColor
       // UITabBar.appearance().tintColor = UIColor.docThemeColor
        UITabBar.appearance().unselectedItemTintColor = .white
        self.tabBarController?.delegate = self
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.btnFont, NSAttributedString.Key.foregroundColor: UIColor.docThemeColor], for: .normal)
        
        var item = tabBar.items![0]
       
        item.title = "PAZIENTI";

        item = tabBar.items![1]
        
        item.title = "NUOVO PAZIENTE";

        
        
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if tabBarController.selectedIndex == 0 {
//            return false
//        }
        return true
    }

}
