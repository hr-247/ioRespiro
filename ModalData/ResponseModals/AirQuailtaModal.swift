//
//  AirQuailtaModal.swift
//  IoRespiro2019
//
//  Created by sanganan on 26/02/2021.
//

import Foundation

struct AirQuailtaModal : Codable
{
    let aqi : Int?
    let createdTime : String?
    let co : String?
    let dew : String?
    let h : String?
    let no2 : String?
    let o3 : String?
    let p : String?
    let pm10 : String?
    let pm25 : String?
    let t : String?
    let w : String?
    let geoLocation : locationModal?
    
    enum CodingKeys : String, CodingKey {
        case aqi = "aqi"
        case createdTime = "createdTime"
        case co = "co"
        case dew = "dew"
        case h = "h"
        case no2 = "no2"
        case o3 = "o3"
        case p = "p"
        case pm10 = "pm10"
        case pm25 = "pm25"
        case t = "t"
        case w = "w"
        case geoLocation = "geoLocation"
        
    }
    
}
struct locationModal : Codable
{
    let x : Double?
    let y : Double?

    
    
    enum CodingKeys : String, CodingKey {
        case x = "x"
        case y = "y"

       
    }
    
}



struct ForecastModal : Codable
{
    let aqi : Float?
    let day : String?

    
    
    enum CodingKeys : String, CodingKey {
        case aqi = "aqi"
        case day = "day"

       
    }
    
}



struct AirQualitaResponseModal : Codable
{
    let results : [AirQuailtaModal]?
    let forecast : [ForecastModal]?
    let cityDetails : CityModal?

    enum CodingKeys : String, CodingKey {
        case results = "results"
        case forecast = "updatedAQIForeCastArr"
        case cityDetails = "cityDetails"

    }
}


struct CityModal : Codable{
    let geo : [Double]?
    let name : String?
    
    enum CodingKeys : String, CodingKey {
        case geo = "geo"
        case name = "name"
        

    }
    
    
}
