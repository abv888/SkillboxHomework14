//
//  RequestModel.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 06.07.2021.
//

import Foundation

struct RequestModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
    
    var cod: String?
    var message: Double?
    var cnt: Double
    var list: [ListModel]
    var city: CityModel
}

struct ListModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case wind = "wind"
        case dt_txt = "dt_txt"
    }
    
    var dt: Double?
    var main: MainModel?
    var weather: [WeatherModel]?
//    var clouds: CloudsModel?
    var wind: WindModel?
//    var visibility: Int?
//    var pop: Float?
//    var sys:SysModel?
//    var snow: SnowModel?
    var dt_txt: String?
    
}

struct MainModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
    
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
//    var sea_level: Int?
//    var grnd_level: Int?
    var humidity: Int?
//    var temp_kf: Int?
//
}

struct WeatherModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    var id: Int?
    var main: String?
    var description : String?
    var icon: String?
    
}

struct CloudsModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
        
    }
    
    var all: Int?
    
}

struct WindModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
       
    }
    
    var speed: Double?
    var deg: Int?
    
}

struct SnowModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case the3h = "the3h"
    }
    
    var the3h: Double?
    
}

struct SysModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case pod = "pod"
    }
    
    var pod: String?
    
}

struct CityModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "lat"
        case name = "lon"
        case country = "country"
        case population = "population"
    }
    
    var id: Double?
    var name: String?
//    var coord: CoordModel?
    var country: String?
    var population: Double?
//    var timezone: Int?
//    var sunrise: Int?
//    var sunset: Int?
    
}

struct CoordModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
    
    var lat: Double?
    var lon: Double?
    
}
