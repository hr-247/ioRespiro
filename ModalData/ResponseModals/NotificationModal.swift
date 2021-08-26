//
//  NotificationModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 27/01/2021.
//

import Foundation

struct NotificationModal : Codable
{
    var type : String?
    
    enum CodingKeys: String, CodingKey {
       
        case type = "type"
        
    }
}
