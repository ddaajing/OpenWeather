//
//  WeatherPage.swift
//  OpenWeather
//
//  Created by jinda on 2022/7/15.
//

import SwiftUI
import Kingfisher

struct WeatherPage: View {
    @StateObject var viewModel: WeatherViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                // loading view
                if (viewModel.isLoading) {
                    ProgressView { Text("Loading").font(.title) }.padding(.top, 140)
                    Spacer()
                } else {
                    // main data
                    VStack{
                        // weather name
                        Text(viewModel.weather?.name ?? "-").font(.system(size: 35)).bold()
                            .onTapGesture {
                                viewModel.getWeatherByCity(viewModel.city!)
                            }
                        Divider().background(Color.white)
                        Text(viewModel.weather?.weather[0].description ?? "-").bold().padding(.top, 20)
                        // icon
                        KFImage(URL(string: viewModel.weather?.weather[0].iconImgUrl ?? "-")!)
                        HStack {
                            Text(viewModel.weather?.main.temp_celsius ?? "-").font(.system(size: 45))
                            VStack{
                                Text("℃").font(.system(size: 25)).frame(alignment: .top).padding(.top, 10)
                                Spacer()
                            }
                        }
                        // max and min temp
                        HStack {
                            HStack {
                                Text("Max \(viewModel.weather?.main.temp_max_celsius ?? "-")").bold()
                                VStack{
                                    Text("℃").font(.system(size: 10)).bold().frame(alignment: .top).padding(.top, 5)
                                    Spacer()
                                }
                            }
                            Text("-").bold()
                            HStack {
                                Text("Min \(viewModel.weather?.main.temp_min_celsius ?? "-")").bold()
                                VStack{
                                    Text("℃").font(.system(size: 10)).bold().frame(alignment: .top).padding(.top, 5)
                                    Spacer()
                                }
                            }
                        }
                    }.padding(.top, 40)
                    // other infomation
                    if ((viewModel.weather) != nil) {
                        OtherInfoList(weather: viewModel.weather!)
                            .frame(alignment: .bottom)
                    }
                }
            }
        }
        .foregroundColor(.white).background(Color.clear)
        .alert(isPresented: $viewModel.showAlert) { // 弹出报错信息
            Alert(title: Text("Error"), message: Text(viewModel.errMsg))
        }
    }
}

struct WeatherPage_Previews: PreviewProvider {
    static var previews: some View {
//        WeatherPage()
        Text("")
    }
}
