//
//  OtherInfoList.swift
//  OpenWeather
//
//  Created by jinda on 2022/7/15.
//

import SwiftUI

struct OtherInfoList: View {
    var weather: WeatherItem

    var body: some View {
        LazyVStack(alignment: .center, spacing: 20) {
            // pressure
            WeatherInfoRow(info: "Pressure: \(weather.main.pressure)hPa")
            Spacer()
            // Humidity
            WeatherInfoRow(info: "Humidity: \(weather.main.humidity)%")
            Spacer()
            // WindSpeed
            WeatherInfoRow(info: "WindSpeed: \(weather.wind.speed)meter/sec")
            Spacer()
            // Sunrise
            WeatherInfoRow(info: "Sunrise: \(dateFormatter.string(from: Date(timeIntervalSince1970: weather.sys.sunrise)))")
            Spacer()
            // Sunset
            WeatherInfoRow(info: "Sunset: \(dateFormatter.string(from: Date(timeIntervalSince1970: weather.sys.sunset)))")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
    }
}

struct OtherInfoList_Previews: PreviewProvider {
    static var previews: some View {
//        OtherInfoList()
        Text("")
    }
}
