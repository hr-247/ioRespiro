//
//  Extension.swift
//  IoRespiro2019
//
//  Created by sanganan on 07/12/2020.
//

import UIKit

extension UIView {
    func makeCorner(withRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.isOpaque = false
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}


extension UITextField {

    
    //MARK:- Set Left Padding of TextField
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setBorderAndColor(textField: UITextField, placeholderTxt: String, txtClr: UIColor, font: UIFont, brdrClr: UIColor)
    {
        textField.attributedPlaceholder = NSAttributedString(string: placeholderTxt,                                                                 attributes: [NSAttributedString.Key.foregroundColor: txtClr])
        textField.textColor = txtClr
        textField.font = font
        textField.setLeftPaddingPoints(20)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = brdrClr.cgColor
        textField.layer.cornerRadius = 30
    }
   
}

extension Int {

    func toDate() -> String
    {
        
        let date = Date(timeIntervalSince1970: TimeInterval(self))
           let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
           dateFormatter.timeZone = .current
           let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    
    
}


extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func toDate() -> String
    {
        guard let time = Double(self) else {
            return self
        }
        let date = Date(timeIntervalSince1970: time)
           let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
           dateFormatter.timeZone = .current
           let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func toDateFormat(dateFormat: String) -> String
    {
        guard let time = Double(self) else {
            return self
        }
        let date = Date(timeIntervalSince1970: time)
           let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
           dateFormatter.timeZone = .current
           let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func toShortDate() -> String
    {
        guard let time = Double(self) else {
            return self
        }
        let date = Date(timeIntervalSince1970: time)
           let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
           dateFormatter.timeZone = .current
           let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func toLargeDate() -> String
    {
        guard let time = Double(self) else {
            return self
        }
        let date = Date(timeIntervalSince1970: time)
           let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
           dateFormatter.timeZone = .current
           let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func convertDateFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"//this your string date format
        dateFormatter.locale = .current
        let convertedDate = dateFormatter.date(from: self)

        guard dateFormatter.date(from: self) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "dd MMM" ///this is what you want to convert format
        let timefinal = dateFormatter.string(from: convertedDate!)

        return timefinal
    }
    
    
    
    func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}



extension Date {
    /// Get current seconds Timestamp - 10 digits
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
         /// Get the current millisecond timestamp - 13 bits
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    var startOfDay: Date {
            return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }

}



