//
//  TestEnableModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 15/02/2021.
//

import Foundation

struct testEnableModal : Codable{
    let catTestList : [TestAssessmentModal]?
    let taiTestList : [TestAssessmentModal]?
    let catCompletedTestList : [TestAssessmentModal]?
    let taiCompletedTestList : [TestAssessmentModal]?
    let catFutureTest : Int?
    let taiFutureTest : Int?
    
    enum CodingKeys : String, CodingKey{
        case catTestList = "catTestList"
        case taiTestList = "taiTestList"
        case catCompletedTestList = "catCompletedTestList"
        case taiCompletedTestList = "taiCompletedTestList"
        case catFutureTest = "catFutureTest"
        case taiFutureTest = "taiFutureTest"
    }
}
