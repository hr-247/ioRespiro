//
//  PatologyModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 12/02/2021.
//

import Foundation

struct PatologyModal  : Codable {
    
    let results : [PatologyListModal]?
    
    enum CodingKeys: String,CodingKey {
        case  results = "results"
    }
}


struct PatologyListModal : Codable
{
    
    let pathology_name : String?
    
    enum CodingKeys: String,CodingKey {
        case pathology_name = "pathology_name"
    }
}
