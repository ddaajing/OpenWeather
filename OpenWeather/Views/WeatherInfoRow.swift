//
//  WeatherInfoRow.swift
//  OpenWeather
//
//  Created by jinda on 2022/7/15.
//

import SwiftUI

struct WeatherInfoRow: View {
    var info: String
    
    var body: some View {
        Text(info).foregroundColor(Color.white)
            .frame(minHeight: 25, idealHeight: 30, maxHeight: 60, alignment: .leading)
    }
}

struct WeatherInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
