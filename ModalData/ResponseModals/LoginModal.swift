


import Foundation


struct LoginModal: Codable {
	let token : String?
    let status : String?
    let usertype : String?
    let linked : Bool?
    let userid : Int?
    let login_status : String?
    
    
	enum CodingKeys: String, CodingKey {
		case token = "token"
        case status = "status"
        case usertype = "usertype"
        case linked = "linked"
        case userid = "userid"
        case login_status = "login_status"
	}
    
}
