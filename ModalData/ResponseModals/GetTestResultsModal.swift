//
//  GetTestResultsModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 30/12/2020.
//

import Foundation

struct GetTestResultsModal : Codable {
    
    let total_score : String?
    let scores : [ScoreModal]?
    let finalScore : Int?
    let results : [ScoreModal]?

    enum CodingKeys: String, CodingKey {
       
        case total_score = "total_score"
        case scores = "scores"
        case finalScore = "finalScore"
        case results = "results"

    }
    
 
}

struct ScoreModal : Codable {
    let question : String?
    let choice : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
       
        case question = "question"
        case choice = "choice"
        case name = "name"

    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        question = try values.decodeIfPresent(String.self, forKey: .question)
//        choice = try values.decodeIfPresent(String.self, forKey: .choice)
//
//    }
}
