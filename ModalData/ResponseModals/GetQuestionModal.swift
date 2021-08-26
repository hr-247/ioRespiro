//
//  GetQuestionModal.swift
//  IoRespiro2019
//
//  Created by Ankit  Jain on 22/12/20.
//

import Foundation


struct GetQuestionModal : Codable {
    
    let id : Int?
    let question : String?
    
    enum CodingKeys: String, CodingKey {
       
        case id = "id"
        case question = "question"

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        question = try values.decodeIfPresent(String.self, forKey: .question)
    }
    
    
}

struct GetCatQuestionModal : Codable {
    
   
    var question : Question?
    
    enum CodingKeys: String, CodingKey {

        case question = "question"

    }
    
    
}


struct Question : Codable {
    let top : String?
    let bottom : String?
    var id : Int?

    enum CodingKeys: String, CodingKey {

        case top = "top"
        case bottom = "bottom"
        case id = "id"


    }
    
}
