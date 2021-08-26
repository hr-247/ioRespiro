//
//  ClassConstants.swift
//  IoRespiro2019
//
//  Created by Sanganan on 19/11/20.
//

import UIKit
import paper_onboarding


class ClassConstants: NSObject {
    
   //MARK:- Dashboards Constants
    static var imgArr = ["PText","VideoEsercizi","PEducazione","PPromemoria","PQualita","PStato"]
    static var txtArr = ["TEST","VIDEO ESERCIZI","EDUCAZIONE","PROMEMORIA","QUALITA DELLARIA","STATO SALUTE"]
    static var docImgArr = ["docTest","docPromemoria","docQualita"]
    static var docTxtArr = ["TEST","PROMEMORIA","QUALITA DELLARIA"]
    
 
    
    //MARK:- Profile Constants
    static var headingArr = ["NOME E COGNOME","DATA DI NASCITA","SESSO","PATOLOGIE RESPIRATORIE","ALTRE PATOLOGIE","NOTE","CODICE PAZIENTE"]
    
    
    static var patientHeadingArr = ["NOME E COGNOME","E-MAIL","DATA DI NASCITA","SESSO","PATOLOGIE RESPIRATORIE","ALTRE PATOLOGIE","NOTE","CODICE PAZIENTE"]
    
    //MARK:- Video Constants
    
    static var videoArr = ["Immagine 2","ambiente 2","ambiente 3"]
    static var lblArr = ["AMBIENTE 1","AMBIENTE 2","AMBIENTE 3"]
    
    //MARK:- Stato Constants
    
    static var statoNmeArr = ["Frequenza Cardiaca","Valore spirometria"]
    
    static var sessoArr = ["UOMO","DONNA"]
    
    static var patArr = ["ASMA","BPCO","NON LO SO"]
    
    static var DaysArr = ["1 Giorno","2 Giorni","3 Giorni","4 Giorni","5 Giorni",
                   "6 Giorni","7 Giorni","8 Giorni","9 Giorni","10 Giorni",
                   "11 Giorno","12 Giorni","13 Giorni","14 Giorni","15 Giorni",
                   "16 Giorni","17 Giorni","18 Giorni","19 Giorni","20 Giorni",
                   "21 Giorno","22 Giorni","23 Giorni","24 Giorni","25 Giorni",
                   "26 Giorni","27 Giorni","28 Giorni","29 Giorni","30 Giorni",
                   "31 Giorno","32 Giorni","33 Giorni","34 Giorni","35 Giorni",
                   "36 Giorni","37 Giorni","38 Giorni","39 Giorni","40 Giorni",
                   "41 Giorno","42 Giorni","43 Giorni","44 Giorni","45 Giorni",
                   "46 Giorni","47 Giorni","48 Giorni","49 Giorni","50 Giorni",
                   "51 Giorno","52 Giorni","53 Giorni","54 Giorni","55 Giorni",
                   "56 Giorni","57 Giorni","58 Giorni","59 Giorni","60 Giorni",
                   "61 Giorno","62 Giorni","63 Giorni","64 Giorni","65 Giorni",
                   "66 Giorni","67 Giorni","68 Giorni","69 Giorni","70 Giorni",
                   "71 Giorno","72 Giorni","73 Giorni","74 Giorni","75 Giorni",
                   "76 Giorni","77 Giorni","78 Giorni","79 Giorni","80 Giorni",
                   "81 Giorno","82 Giorni","83 Giorni","84 Giorni","85 Giorni",
                   "86 Giorni","87 Giorni","88 Giorni","89 Giorni","90 Giorni",
                   "91 Giorno","92 Giorni","93 Giorni","94 Giorni","95 Giorni",
                   "96 Giorni","97 Giorni","98 Giorni","99 Giorni","100 Giorni"]
    
    
    //MARK:- Air Quality Index
    
    static var airQualityIndexArr = ["Nessun Rischio.","Sintomi all'apparato respiratorio per persone particolarmente sensibili.","Sintomi all'apparato respiratorio e potenziale pericolo per cuore e polmoni in persone affette da gravi disturbi all'apparato cardio- circolatorio.","Si consiglia attività ridotta per i gruppi sensibili,possibili sintomi anche nella popolazione generale.","Aggravarsi di episodi acuti in gruppi sensibili,consiglia ridotta attività all'aperto per tutti.","Massimo rischio per i gruppi sensibili,fortemente consigliata la riduzione dell'attività all'aperto."]
    
   
    
    
    
    // MARK: - SplashConstants
   
    static let splashArray : [OnboardingItemInfo] = [
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Group 3421"),
                                      title: "ioRespiro",
                                description: "Mettiti in \ncontatto con i medici",
                                pageIcon: #imageLiteral(resourceName: "Ellipse") ,
                                   color: UIColor.clear,
                                 titleColor: UIColor.patientThemeColor,
                           descriptionColor: UIColor.patientThemeColor,
                                  titleFont: UIFont.infoScreenHeadingFont,
                            descriptionFont: UIFont.infoScreenRegularFont),

          OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Group 3429"),
                                        title: "Medico",
                                  description: "Ricevi consigli",
                                     pageIcon: #imageLiteral(resourceName: "Ellipse"),
                                        color: UIColor.clear,
                                   titleColor: UIColor.patientThemeColor,
                             descriptionColor: UIColor.patientThemeColor,
                                    titleFont: UIFont.infoScreenHeadingFont,
                              descriptionFont: UIFont.infoScreenRegularFont),

          OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Group 3432"),
                                        title: "Paziente",
                                  description: "Monitora la\ntua salute",
                                     pageIcon: #imageLiteral(resourceName: "Ellipse"),
                                        color: UIColor.clear,
                                   titleColor: UIColor.patientThemeColor,
                             descriptionColor: UIColor.patientThemeColor,
                                    titleFont: UIFont.infoScreenHeadingFont,
                              descriptionFont: UIFont.infoScreenRegularFont)
        
        ]
    
    
    
    //MARK:- Keys To Save Data Locally
    struct Datakeys{
        static let token   = "token"
        static let type   = "type"
        static let fcmToken = "fcmToken"
        static let patientCode = "patientCode"
        static let userId = "userId"
        static let email = "email"
        static let currentLatitude = "currentLatitude"
        static let currentLongitude = "currentLongitude"

    }
    
    struct UserType{
        static let patient   = "PATIENT"
        static let doctor   = "DOCTOR"

    }
    
}
