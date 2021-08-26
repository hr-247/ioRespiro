//
//  PatientTestModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 29/12/2020.
//

import Foundation


struct PatientTestModal : Codable {
    
  //  let batch_number : String?
    let name : String?

    enum CodingKeys: String, CodingKey {
       
        case name = "name"

    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)

    }
 
}

