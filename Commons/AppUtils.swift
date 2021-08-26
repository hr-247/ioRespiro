//
//  AppUtils.swift
//  IoRespiro2019
//
//  Created by sanganan on 07/12/2020.
//

import UIKit
import Toaster

class AppUtils {
    
    static func showToast(message : String)
    {
        let toast = Toast(text: message, delay: 0.1, duration: 2.0)
        toast.view.backgroundColor = .black
        toast.view.textColor = .white
        toast.view.font = UIFont.systemFont(ofSize: 17)
        toast.show()
                
    }
    
      
    static func AppDelegate() -> AppDelegate{
           return UIApplication.shared.delegate as! AppDelegate
       }
    
    static func getParticularTimeFormat(format:String ,date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = format
        let strDate = dateFormatter.string(from: date)
        
        return String(describing: strDate)
    }
    
    
    static func showResultForTai(score : Int) -> String
    {
        if score < 45 {
            
            return "Cattiva Adesione"
        }else if score < 50
        {
            return "Adesione Intermedia"
        }else
        {
            return "Buona Adesione"
        }
        
        
    }
    
    static func showResultForCat(score : Int) -> String
    {
        if score < 11 {
            
            return "Impatto ridotto"
        }else if score < 21
        {
            return "Impatto Medio"
        }else if score < 31
        {
            return "Impatto elevato"
        }else
        {
            return "Impatto molto elevato"

        }
        
        
    }
    
    
}
