//
//  SubmitTest.swift
//  IoRespiro2019
//
//  Created by Ankit  Jain on 23/12/20.
//

import Foundation

struct SubmitTest : Codable {
    
    let message : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"


    }
    
   
    
}

struct LinkPatient : Codable {
    
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"


    }
    
   
    
}
