//
//  ChoiceModal.swift
//  IoRespiro2019
//
//  Created by Ankit  Jain on 22/12/20.
//

import Foundation

struct ChoiceModal : Codable {
    
    let id : Int?
    let name : String?
    let score : Int?

    enum CodingKeys: String, CodingKey {
       
        case id = "id"
        case name = "name"
        case score = "score"


    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        score = try values.decodeIfPresent(Int.self, forKey: .score)

    }
    
    
}
