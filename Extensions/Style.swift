//
//  Color.swift
//  IoRespiro2019
//
//  Created by Sanganan on 19/11/20.
//

import UIKit



extension UIColor {
    static var appThemeColor : UIColor {
        
        if let color = UIColor(named: "ThemeColor")
        {
            return color
        }
        return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
    }
    static var appHeaderColor : UIColor {
        return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
    }
    static var patientThemeColor : UIColor {
        return UIColor(red: 185/255, green: 05/255, blue: 103/255, alpha: 1)
    }
    static var darkPatientTheme : UIColor {
        return UIColor(red: 165/255, green: 13/255, blue: 94/255, alpha: 1)
    }
    static var lineColor : UIColor {
        return UIColor(red: 103/255, green: 103/255, blue: 103/255, alpha: 1)
    }
    static var headingColor : UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    static var docThemeColor : UIColor {
        return UIColor(red: 9/255, green: 78/255, blue: 128/255, alpha: 1)
    }
    static var borderColor : UIColor {
        return UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
    }
    static var textColor : UIColor {
        return UIColor(red: 49/255, green: 52/255, blue: 80/255, alpha: 1)
    }
    static var quesColor : UIColor {
        return UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
    }
    static var statusBarColor : UIColor {
        return UIColor(red: 168/255, green: 0/255, blue: 84/255, alpha: 1)
    }
    static var appBackgroundColor : UIColor {
        return UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
    }
    static var patientShadowColor : UIColor {
        return UIColor(red: 136/255, green: 14/255, blue: 79/255, alpha: 0.97)
    }
    static var docShadowColor : UIColor {
        return UIColor(red: 0/255, green: 98/255, blue: 147/255, alpha: 1)
    }
    static var docFadeColor : UIColor {
        return UIColor(red: 45/255, green: 114/255, blue: 149/255, alpha: 0.53)
    }
    static var airQualitaYellow : UIColor {
        return UIColor(red: 254/255, green: 210/255, blue: 1/255, alpha: 1)
    }
    static var airQualitaRed : UIColor {
        return UIColor(red: 185/255, green: 5/255, blue: 5/255, alpha: 1)
    }
    static var airQualitaGreen : UIColor {
        return UIColor(red: 5/255, green: 185/255, blue: 95/255, alpha: 1)
    }
    
    
    
}

struct AppFontName {
    static let bold = "Ubuntu-Bold"
    static let boldItalic = "Ubuntu-BoldItalic"
    static let Italic = "Ubuntu-Italic"
    static let light = "Ubuntu-Light"
    static let lightItalic = "Ubuntu-LightItalic"
    static let medium = "Ubuntu-Medium"
    static let mediumItalic = "Ubuntu-MediumItalic"
    static let regular = "Ubuntu-Regular"
    static let poppinsExtraLight = "Poppins-ExtraLight"
    static let poppinsBold = "Poppins-Bold"
    static let poppinsMedium = "Poppins-Medium"
    static let poppinsRegular = "Poppins-Regular"
    static let poppinsLight = "Poppins-Light"
    static let ralewayBold = "Raleway-Bold"
    static let ralewayMedium = "Raleway-Medium"
    
}




extension UIFont {
    
    static var appHeading: UIFont {
        return UIFont(name: AppFontName.bold, size: 25)!
    }
    static var appTitle: UIFont {
        return UIFont(name: AppFontName.regular, size: 20)!
    }
    static var appTitle2: UIFont {
        return UIFont(name: AppFontName.regular, size: 25)!
    }
    static var appHeadingBody : UIFont {
        return UIFont(name: AppFontName.bold, size: 20)!
        
    }
    static var btnFont : UIFont {
        return UIFont(name: AppFontName.bold, size: 18)!
        
    }
    
    static var lightFont : UIFont {
        return UIFont(name: AppFontName.regular, size: 18)!
        
    }
    static var txtFontBold : UIFont {
        return UIFont(name: AppFontName.bold, size: 17)!
        
    }
    
    static var textFont : UIFont {
        return UIFont(name: AppFontName.regular, size: 17)!
        
    }
    
    static var infoScreenRegularFont : UIFont {
        return UIFont(name: AppFontName.poppinsRegular, size: 27)!
        
    }
    static var infoScreenHeadingFont : UIFont {
        return UIFont(name: AppFontName.poppinsBold, size: 30)!
        
    }
    
    static var homeScreenFont : UIFont {
        return UIFont(name: AppFontName.ralewayBold, size: 26)!
        
    }
    static var homeScreenTextFieldFont : UIFont {
        return UIFont(name: AppFontName.ralewayMedium, size: 26)!
        
    }
    static var profileListFont : UIFont {
        return UIFont(name: AppFontName.regular, size: 11)!
        
    }
}







