//
//  RegisterModal.swift
//  IoRespiro2019
//
//  Created by Ankit  Jain on 15/12/20.
//

import Foundation

struct RegisterModal : Codable {
    let message : String?
    let errors : Errors?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case errors = "errors"
    }
}


struct Errors : Codable {
    let email : [String]?

    enum CodingKeys: String, CodingKey {

        case email = "email"
    }

   

}
