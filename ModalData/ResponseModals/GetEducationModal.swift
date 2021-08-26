//
//  GetEducationModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 05/01/2021.
//

import Foundation

struct GetEducationModal : Codable
{
   
    let id : Int?
    let data : EduDataModal?
    let created_at : String?
    
    enum CodingKeys: String, CodingKey {
       
        case data = "data"
        case created_at = "created_at"
        case id = "id"

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        data = try values.decodeIfPresent(EduDataModal.self, forKey: .data)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(data, forKey: .data)
        try container.encode(created_at, forKey: .created_at)

        
    }
    
//        init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        if let id = try container.decode(String?.self, forKey: .id) {
//            self.id = id
//        }
//        if let name = try container.decode(String?.self, forKey: .name) {
//           self.name = name
//        }
//        if let email = try container.decode(String?.self, forKey: .email){
//           self.email = email
//        }
//        if let type = try container.decode(String?.self, forKey: .type){
//           self.type = type
//        }
//        if let patient_profile = try container.decode(ProfileModal?.self, forKey: .patient_profile){
//           self.patient_profile = patient_profile
//        }
//    
//        }
    
    
}
    
    
    
    
    struct EduDataModal : Codable
    {
    
    let content : String?
    let title : String?
    let image_url : String?
        
    
    enum CodingKeys: String, CodingKey {
       
        case content = "content"
        case title = "title"
        case image_url = "image_url"

    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)

    }
}
