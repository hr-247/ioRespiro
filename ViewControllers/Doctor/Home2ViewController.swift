//
//  Home2ViewController.swift
//  IoRespiro2019
//
//  Created by sanganan on 11/12/2020.
//

import UIKit

class Home2ViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var subHeadingLbl: UILabel!
    @IBOutlet weak var dscLbl: UILabel!
    @IBOutlet weak var topHeadingCons: NSLayoutConstraint!
    @IBOutlet weak var imgHeightCons: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.docThemeColor
        headingLblUI()
        subHeadingLblUI()
        dscLblUI()
       // addBackButton()
        
    }
    

    func headingLblUI()
    {
        imgHeightCons.constant = 0.4*UIScreen.main.bounds.height;
        topHeadingCons.constant = 0.04*UIScreen.main.bounds.height;
        headingLbl.text = "Home"
        headingLbl.textColor = UIColor.headingColor
        headingLbl.font = UIFont.appTitle2
    }
    
    func subHeadingLblUI()
    {
        subHeadingLbl.text = "Sei pronto?"
        subHeadingLbl.textColor = UIColor.docThemeColor
        subHeadingLbl.font = UIFont.appTitle2
        
    }
    
    func dscLblUI(){
        
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.docThemeColor, NSAttributedString.Key.font: UIFont(name: AppFontName.bold, size: 35.0)]
        
        var str1 = NSAttributedString(string: "io")
        var str2 = NSAttributedString(string: "\ne'l' ")
        var str3 = NSAttributedString(string: "\nper il settore ")
        let attrStr1 = NSAttributedString(string: "Respiro", attributes: myAttribute)
        let attrStr2 = NSAttributedString(string: "APP", attributes: myAttribute)
        let attrStr3 = NSAttributedString(string: "\nRESPIRATORIO", attributes: myAttribute)
        
        
       
        

       // str1.append(myAttrString)
        
        
        dscLbl.text = "ioRespiro \ne'l' APP \nper il settore \nRESPIRATORIO"
        dscLbl.textColor = UIColor.docThemeColor
        dscLbl.textAlignment = .center
        dscLbl.font = UIFont(name: AppFontName.regular, size: 35.0)
        
    }

}
