//
//  PatientDashboardViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 09/12/2020.
//

import UIKit

class PatientDashboardViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        clearNavigationStack()
        // Do any additional setup after loading the view.
         self.delegate = self
        customizeUITabBar()
        addSeparatorToTabBar()
    }
    

    
    
    
    func customizeUITabBar(){
        
        var  bottomPadding : CGFloat = 0.0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = window?.safeAreaInsets.bottom ?? 0
            
        }
        
//        let  topInset = (bottomPadding == 0) ? 0 : 1

        let  topInset = 0

        
        
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: self.tabBar.frame.height - CGFloat(topInset) + bottomPadding)
//        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.white , size: tabBarItemSize).resizableImage(withCapInsets: .init(top: 0, left: 0, bottom: bottomPadding, right: 0))
        
        
        
        
        UITabBar.appearance().selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.white, size: tabBarItemSize)
               // Uses the original colors for your images, so they aren't not rendered as grey automatically.
               for item in (self.tabBar.items)! {
               if let image = item.image {
                   item.image = image.withRenderingMode(.alwaysOriginal)
               }
           }
        
        
        

        // remove default border
        tabBar.frame.size.width = self.view.frame.width
        tabBar.frame.origin.x = 0
        
        UITabBar.appearance().barTintColor = UIColor.patientThemeColor
        UITabBar.appearance().tintColor = UIColor.patientThemeColor
        UITabBar.appearance().unselectedItemTintColor = .white
        
        
        
        
    }
    
   
    fileprivate func addSeparatorToTabBar() {
        if let items = self.tabBar.items {

            //Get the height of the tab bar

            let height = (self.tabBar.bounds).height

            //Calculate the size of the items

            let numItems = CGFloat(items.count)
            let itemSize = CGSize(
                width: (self.tabBar.frame.width) / numItems,
                height: (self.tabBar.frame.height))

            for (index, _) in items.enumerated() {

                //We don't want a separator on the left of the first item.

                if index > 0 {

                    //Xposition of the item

                    let xPosition = itemSize.width * CGFloat(index)

                    /* Create UI view at the Xposition,
                     with a width of 0.5 and height equal
                     to the tab bar height, and give the
                     view a background color
                     */
                    let separator = UIView(frame: CGRect(
                        x: xPosition, y: 0, width: 0.5, height: height))
                    separator.backgroundColor = UIColor.white
                    self.tabBar.insertSubview(separator, at: 1)
                }
            }
        }
    }

}


extension UIImage {

   class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
   }
}
