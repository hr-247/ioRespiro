//
//  VideoModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 27/01/2021.
//

import Foundation

struct VideoModal : Codable
{
    var url : String?
    let type : String?
    
    enum CodingKeys: String, CodingKey {
       
        case url = "url"
        case type = "type"
        
    }
}
