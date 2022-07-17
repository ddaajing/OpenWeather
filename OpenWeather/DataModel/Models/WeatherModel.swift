//
//  WeatherModel.swift
//  OpenWeather
//
//  Created by jinda on 2022/7/15.
//

import Swift

struct WeatherMain: Codable {
    // temp
    var temp: Double
    var temp_celsius : String {
        return String(format: "%.1f", temp - 273.15)
    }
    // temp_min
    var temp_min: Double
    var temp_min_celsius : String {
        return String(format: "%.1f", temp_min - 273.15)
    }
    // temp_max
    var temp_max: Double
    var temp_max_celsius : String {
        return String(format: "%.1f", temp_max - 273.15)
    }
    // pressure
    var pressure: Int
    // humidity
    var humidity: Int
}

struct WeatherInfo: Codable {
    // weather icon
    var icon: String
    var iconImgUrl: String {
        return "http://openweathermap.org/img/wn/\(icon)@2x.png"
    }
    // weather description
    var description:String
}

struct WeatherWind: Codable {
    // wind speed
    var speed: Double
    // deg
    var deg:Int
}

struct WeatherSys: Codable {
    // sunrise time
    var sunrise: Double
    // sunset time
    var sunset: Double
}

// Weather item 
struct WeatherItem: Codable {
    var id: Int
    var name:String
    let main:WeatherMain
    let weather:[WeatherInfo]
    let wind:WeatherWind
    let sys:WeatherSys
}
