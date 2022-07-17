//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by jinda on 2022/7/16.
//

import Foundation
import Combine

// WeatherPage viewmodel 
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherItem? = nil
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = true
    @Published var errMsg: String = ""
    @Published var city: City? = nil
    
    private var cancellableSet: Set<AnyCancellable> = []
    var svc: ServiceProtocol

    init(svc: ServiceProtocol = Service.shared, city: City) {
        self.svc = svc
        self.city = city
        getWeatherByCity(city)
    }

    // get weather info from service
    func getWeatherByCity(_ city: City) {
        // show loading view
        self.isLoading = true
        
        svc.fetchWeatherByCity(city)
            .sink { (dataResponse) in
                // show error
                if dataResponse.error != nil {
                    self.errMsg = dataResponse.error!.backendError == nil ?
                        dataResponse.error!.initialError.localizedDescription : dataResponse.error!.backendError!.message
                    self.isLoading = false
                    self.showAlert = true
                } else {
                    // weather data assignment to refresh view
                    self.weather = dataResponse.value!
                    self.isLoading = false
                }
            }.store(in: &cancellableSet)
    }
}
