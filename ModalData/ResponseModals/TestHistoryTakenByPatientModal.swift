//
//  TestHistoryTakenByPatientModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 09/02/2021.
//

import Foundation


struct TestHistoryTakenByPatientModal : Codable
{
    var results : [UsedTestList]?
    
    enum CodingKeys: String, CodingKey{
        case results = "results"
    }
}

struct UsedTestList : Codable
{
    var id : Int?
    var assignedtestid  : Int?
    var Status  : Int?

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case assignedtestid = "assignedtestid"
        case Status = "Status"

    }
}
