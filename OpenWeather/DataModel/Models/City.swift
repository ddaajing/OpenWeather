//
//  City.swift
//  OpenWeather
//
//  Created by jinda on 2022/7/15.
//

import Foundation

// City model
struct City: Hashable, Codable, Identifiable {
    // id
    public var id: Int
    // name
    var name:String
    // lat
    var lat: String
    // lon
    var lon: String
}
