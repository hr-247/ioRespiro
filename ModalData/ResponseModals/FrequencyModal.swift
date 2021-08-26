//
//  FrequencyModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 09/02/2021.
//

import Foundation

struct FrequencyModal : Codable{
    
    var results : [FrequencyListModal]?
    
    enum CodingKeys: String, CodingKey {
       
        case results = "results"
        
    }
    
    
    
}

struct FrequencyListModal : Codable
{
    var Desc : String?
    var id : Int?

    enum CodingKeys: String, CodingKey{
        
        case Desc = "Desc"
        case id = "id"

    }
}
