//
//  ContentView.swift
//  OpenWeather
//
//  Created by jinda on 2022/7/15.
//

import SwiftUI
import SwiftUIPager

struct ContentView: View {
    @StateObject var page: Page = .first()

    var body: some View {
        ZStack{
            // background
            Image("weather_bg").resizable()
            // view pager
            Pager(page: page,
                  data: cities,
                  id: \.self,
                  content: { city in
                WeatherPage(viewModel: WeatherViewModel(city: city))
            })
            .itemSpacing(10)
            .horizontal()
            .padding(8)
            .alignment(.center)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
