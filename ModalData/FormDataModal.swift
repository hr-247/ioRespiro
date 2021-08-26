//
//  FormDataModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 08/12/2020.
//

import UIKit

struct FormModal : Codable
{
    var name : String?
    var email : String?
    var patology : String?
    var location : String?
    var password : String?
    var confirmPassword : String?
    var date_of_birth : String?
    var sex : String?
    var patologie_respiratorie : String?
    var altre_respiratorie : [String]?
    var note : String?
    var patient_code : String?
    var tnCAccept : Bool?

    
}
