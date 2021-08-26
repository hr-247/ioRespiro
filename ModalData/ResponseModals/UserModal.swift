//
//  UserModal.swift
//  IoRespiro2019
//
//  Created by Ankit  Jain on 22/12/20.
//

import Foundation

struct UserModal: Decodable {
    
    var id : Int?
    var name : String?
    var email : String?
    let type : String?
    var patient_profile : ProfileModal?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case type = "type"
        case patient_profile = "patient_profile"
    }
    
    
//    init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    if let id = try container.decode(Int?.self, forKey: .id) {
//        self.id = id
//    }
//    if let name = try container.decode(String?.self, forKey: .name) {
//       self.name = name
//    }
//    if let email = try container.decode(String?.self, forKey: .email){
//       self.email = email
//    }
//    if let type = try container.decode(String?.self, forKey: .type){
//       self.type = type
//    }
//    if let patient_profile = try container.decode(ProfileModal?.self, forKey: .patient_profile){
//       self.patient_profile = patient_profile
//    }
//
//    }
}
    
    
    
    
    
    


struct ProfileModal : Decodable
{
    var patologie : String?
    var patient_code : String?
    var date_of_birth : String?
    var sex : String?
    var patologie_respiratorie : String?
    var altre_respiratorie : QuantumValue?
    var note : String?
    var name : String?
    
    enum CodingKeys: String, CodingKey {
       
        case patologie = "patologie"
        case patient_code = "patient_code"
        case date_of_birth = "date_of_birth"
        case sex = "sex"
        case patologie_respiratorie = "patologie_respiratorie"
        case altre_respiratorie = "altre_respiratorie"
        case note = "note"
        case name = "name"
    }
    
    
//    init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    if let patologie = try container.decode(String?.self, forKey: .patologie) {
//        self.patologie = patologie
//    }
//    if let patient_code = try container.decode(String?.self, forKey: .patient_code) {
//       self.patient_code = patient_code
//    }
//    if let date_of_birth = try container.decode(String?.self, forKey: .date_of_birth){
//       self.date_of_birth = date_of_birth
//    }
//    if let sex = try container.decode(String?.self, forKey: .sex){
//       self.sex = sex
//    }
//    if let patologie_respiratorie = try container.decode(String?.self, forKey: .patologie_respiratorie){
//       self.patologie_respiratorie = patologie_respiratorie
//    }
////        if let altre_respiratorie = try container.decode(QuantumValue?.self, forKey: .altre_respiratorie){
////           self.altre_respiratorie = altre_respiratorie
////        }
//
//        if let altre_respiratorie = try container.decodeIfPresent(QuantumValue?.self, forKey: .altre_respiratorie)
//        {
//           self.altre_respiratorie = altre_respiratorie
//        }else
//        {
////            self.altre_respiratorie = try? QuantumValue(from: JSONDecoder() as! Decoder)
//        }
//
//        if let note = try container.decode(String?.self, forKey: .note){
//           self.note = note
//        }
//        if let name = try container.decode(String?.self, forKey: .name){
//           self.name = name
//        }
//
//    }
    
    
    
}


struct Profile : Decodable
{
    var patologie : String?
    var patient_code : String?
    var date_of_birth : String?
    var sex : String?
    var patologie_respiratorie : String?
  // var altre_respiratorie : QuantumValue?
    var note : String?
    var name : String?
    
    enum CodingKeys: String, CodingKey {
       
        case patologie = "patologie"
        case patient_code = "patient_code"
        case date_of_birth = "date_of_birth"
        case sex = "sex"
        case patologie_respiratorie = "patologie_respiratorie"
     //   case altre_respiratorie = "altre_respiratorie"
        case note = "note"
        case name = "name"
    }
    

    
}


struct ProfileFrmDrSide : Decodable {
    var results : [ProfileModal]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    
}




enum QuantumValue: Decodable {

    case array([String]), string(String)

    
    init(from decoder: Decoder) throws {
        if let arr = try? decoder.singleValueContainer().decode([String].self) {
            self = .array(arr)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        

        throw QuantumError.missingValue
    }

    enum QuantumError:Error {
        case missingValue
    }
}


