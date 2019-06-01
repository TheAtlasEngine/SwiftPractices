//
//  WeatherData.swift
//  TestDispatchQueue
//
//  Created by Kosuke Nishimura on 2019/06/01.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import Foundation

class WeatherData: Codable {
    var weather: [WeatherAtEachPlace]
    var airCondition: AirCondition
    var sys: Sys
    var city: String
    
    private enum CodingKeys: String, CodingKey {
        case weather = "weather"
        case airCondition = "main"
        case sys = "sys"
        case city = "name"
    }
}

class WeatherAtEachPlace: Codable {
    var main: String
    var description: String
    
    private enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
    }
}

class AirCondition: Codable {
    var temperature: Float
    var temperatureMax: Float
    var temperatureMin: Float
    var pressure: Float
    var humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}

class Sys: Codable {
    var country: String
    
    private enum CodingKeys: String, CodingKey {
        case country = "country"
    }
}

