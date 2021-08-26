//
//  Constant.swift
//  IoRespiro2019
//
//  Created by Sanganan on 18/11/20.
//

import Foundation
import UIKit

class Constant: NSObject {
    
    //MARK :- Constant Value
    static let leftPaddingPointsVal : CGFloat = 55.0
    static let btnBorderWidth : CGFloat = 2.0
    static let headingConstraint : CGFloat = 0.04
    //variables
    static let estimateWidth = 160.0
    static let cellMarginSize = 20.0
    
    
    //MARK:- Messages to Display
    struct Msg{
        static let invalNmeMsg   = "Username errati"
        static let allFldsManMsg = "Tutti i campi sono obbligatori"
        static let invalEmailMsg = "Email errati"
        static let passwordNotMatch = "Le due password non coincidono"
        static let emptyFieldMsg = "I campi della password sono vuoti"
        static let tncMsg = "Perfavore accettare termini e condizioni"
        static let offlineMsg    = "Senza internet. Per favore controlla la tua connessione Internet"
        static let errorMsg      = "Qualcosa è andato storto"
        static let invalidCredentials      = "Credenziali errate"
        static let invalidRegister      = "Errore di registrazione"
        static let loginSuccess      = "Accesso riuscito"
        static let allQuestionMandatory = "Tutte le domande sono obbligatorie"
        static let unauthenticated = "Non autenticato"
        static let codeMsg = "Inserisci il codice"
        static let regCompleteMsg = "Registrazione completata, verifica la tua email"
        static let approvalPending      = "La tua approvazione è in attesa"
        static let emailVerificationPending = "Per favore verifica la tua email"
        static let invalidVideoPath = "Percorso video non valido"
        static let locServiceNotEnabled = "I servizi di localizzazione non sono abilitati"
        static let dataSaved = "Dati salvati con successo"
        static let noData = "Nessun dato trovato"

    }
    
    
    
    //MARK:- STORYBOARDS
    public struct Storyboards
    {
        static let main = UIStoryboard(name: "Main", bundle: nil)
        static let doctor = UIStoryboard(name: "Doctor", bundle: nil)
        static let patient = UIStoryboard(name: "Patient", bundle: nil)
    }
    
    //MARK:- ViewControllers
    public enum Controllers {
        case splash
        case landingPage
        case customerType
        case docRegistration
        case docLogin
        case patientRegistration
        case patientLogin
        case docDashboard
        case patientDashboard
        case test
        case testTai
        case testSampre
        case docDashTab
        case home1
        case home3
        case profile
        case ambient1
        case ambient2
        case ambient3
        case video
        case stato
        case addStato
        case doctorDash
        case docTest
        case docPromemoria
        case addPatientPromemoria
        case patientProfile
        case patientQualita
        case forgetPass
        case patientForgetPass
        case docLogout
        case educazione
        case PPromemoria
        case pProfileModify
        case menu
        case eduDetail
        case docQualita
        case docNoTstAssgnd
        case assegnaTest
        case assignatiTest
        case patientAssignati
        case storicoList
        case freqList
        case archiveTestList
        case patientStato
        case wearable
        case notification
        case rangeChart
        case progressRing
        
        
       
        
        func get()->UIViewController{
            switch self {
                
            case .splash:
                return Storyboards.main.instantiateViewController(withIdentifier: "SplashViewController")
            case .landingPage:
                return Storyboards.main.instantiateViewController(withIdentifier: "LandingPageViewController")
            
            case .customerType:
                return Storyboards.main.instantiateViewController(withIdentifier: "CustomerTypeViewController")
            case .docRegistration:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "DocRegistrationViewController")
            case .patientRegistration:
                return Storyboards.patient.instantiateViewController(withIdentifier: "PatientRegistrationViewController")
            case .patientLogin:
                return Storyboards.patient.instantiateViewController(withIdentifier: "PatientLoginViewController")
            case .docLogin:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "DocLoginViewController")
            case .docDashboard:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "DocDashboardViewController")
            case .patientDashboard:
                return Storyboards.patient.instantiateViewController(withIdentifier: "PatientDashboardViewController")
            case .testTai:
                return Storyboards.patient.instantiateViewController(withIdentifier: "TestTaiViewController")
            case .testSampre:
                return Storyboards.patient.instantiateViewController(withIdentifier: "TestSampreViewController")
            case .docDashTab:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "DocDashTabBarViewController")
            case .home1:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "Home1ViewController")
            case .test:
                return Storyboards.patient.instantiateViewController(withIdentifier: "TestViewController")
            case .profile:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "ProfileViewController")
            case .ambient1:
                return Storyboards.patient.instantiateViewController(withIdentifier: "Ambiente1ViewController")
            case .ambient2:
                return Storyboards.patient.instantiateViewController(withIdentifier: "Ambiente2ViewController")
            case .ambient3:
                return Storyboards.patient.instantiateViewController(withIdentifier: "Ambiente3ViewController")
            case .video:
                return Storyboards.patient.instantiateViewController(withIdentifier: "VideoViewController")
            case .stato:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "StatoSaluteViewController")
            case .addStato:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "AddStatoSaluteViewController")
            case .home3:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "Home3ViewController")
            case .doctorDash:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "DoctorDashboardViewController")
            case .docTest:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "DocTestViewController")
            case .docPromemoria:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "DocPromemoriaViewController")
            case .addPatientPromemoria:
                return Storyboards.patient.instantiateViewController(withIdentifier: "AddPatientPromemoriaViewController")
            case .patientProfile:
                return Storyboards.patient.instantiateViewController(withIdentifier: "PatientProfileViewController")
            
            case .patientQualita:
                return Storyboards.patient.instantiateViewController(withIdentifier: "QualitaViewController")
            case .forgetPass:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "ForgetPasswordViewController")
            case .patientForgetPass:
                return Storyboards.patient.instantiateViewController(withIdentifier: "PatientForgetPasswordViewController")
            case .docLogout:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "ViewController")
            case .educazione:
                return Storyboards.patient.instantiateViewController(withIdentifier: "EduViewController")
            case .PPromemoria:
                return Storyboards.patient.instantiateViewController(withIdentifier: "PatientPromemoriaViewController")
            case .pProfileModify:
                return Storyboards.patient.instantiateViewController(withIdentifier: "PatientProfileModifyViewController")
            case .menu:
                return Storyboards.patient.instantiateViewController(withIdentifier: "MenuViewController")
            case .eduDetail:
                return Storyboards.patient.instantiateViewController(withIdentifier: "EduDetailViewController")
            case .docQualita:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "DocQualitaViewController")
            case .docNoTstAssgnd:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "DocNoTestAssignedViewController")
            case .assegnaTest:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "AssegnaTestViewController")
            case .assignatiTest:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "AssignatiTestViewController")
            case .patientAssignati:
                return Storyboards.patient.instantiateViewController(withIdentifier: "PatientAssignatiViewController")
            case .storicoList:
                return Storyboards.patient.instantiateViewController(withIdentifier: "StoricoListViewController")
            case .freqList:
                return Storyboards.doctor.instantiateViewController(withIdentifier: "FrequencyViewController")
            case .archiveTestList:
                return Storyboards.patient.instantiateViewController(withIdentifier: "ArchiveTestListViewController")
            case .patientStato:
                return Storyboards.patient.instantiateViewController(withIdentifier: "PatientStatoSaluteViewController")
            case .wearable:
                return Storyboards.patient.instantiateViewController(withIdentifier: "WearableViewController")
            case .notification:
                return Storyboards.patient.instantiateViewController(withIdentifier: "WearableViewController")
            case .rangeChart:
                return Storyboards.patient.instantiateViewController(withIdentifier: "AirQualityChartViewController")
            case .progressRing:
                return Storyboards.patient.instantiateViewController(withIdentifier: "ProgressRingViewController")
            }
        }
    }
    
    
    
}
