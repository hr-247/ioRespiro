//
//  DoctorProfileModal.swift
//  IoRespiro2019
//
//  Created by Ankit  Jain on 09/02/21.
//

import Foundation


struct DoctorProfile : Codable {
    var status : Int?
    var results : [Approval]?
    var patientCount : [LinkedPatients]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case results = "results"
        case patientCount = "patientCount"


    }
    
}

struct Approval : Codable {
    var admin_permissions : Int?
     enum CodingKeys: String, CodingKey {
        case admin_permissions = "admin_permissions"
    }
    
}


struct LinkedPatients : Codable {
    var patientCount : Int?
    enum CodingKeys: String, CodingKey {
        case patientCount = "patientCount"
    }
    
}
