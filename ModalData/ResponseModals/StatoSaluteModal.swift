//
//  StatoSaluteModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 10/03/2021.
//

import Foundation

struct StatoSaluteModal : Codable {
    let result : [HealthTestModal]?
    
    enum Codingkeys : String,CodingKey{
        case result = "result"
    }
}


struct HealthTestModal : Codable
{
    let id : Int?
    let name : String?
    
    enum CodingKeys : String,CodingKey{
        case id = "id"
        case name = "name"
    }
}
