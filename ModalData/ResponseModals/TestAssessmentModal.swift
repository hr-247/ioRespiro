//
//  TestAssessmentModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 27/01/2021.
//

import Foundation


struct TestModal : Codable {
    
    var tests : [TestAssessmentModal]?
    let testList : [TestAssessmentModal]?
   
    
    enum CodingKeys: String, CodingKey {
        
        case tests = "tests"
        case testList = "testList"
       

    }
}


struct TestAssessmentModal : Codable {
    var id : Int?
    var frequency : Int?
    var start_date : String?
    var created_at : String?
    var type : String?
    var repetitions : String?
    var Desc : String?
    let test_status : Int?
    let Status : Int?
    let assignedtestid : Int?
    var results : [ResultModal]?
    var description : [FrequencyDesc]?

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case frequency = "frequency"
        case start_date = "start_date"
        case created_at = "created_at"
        case type = "type"
        case repetitions = "repetitions"
        case test_status = "test_status"
        case Status = "Status"
        case assignedtestid = "assignedtestid"
        case results = "results"
        case description = "Description"


    }
}

struct FrequencyDesc : Codable
{
    var id : Int?
    var Desc : String?
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case Desc = "Desc"
    }
    
}



struct ResultModal : Codable
{
    var batch_number : String?
    var created_at : String?
    let assigned_test_id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case batch_number = "batch_number"
        case created_at = "created_at"
        case assigned_test_id = "assigned_test_id"

    }
}
