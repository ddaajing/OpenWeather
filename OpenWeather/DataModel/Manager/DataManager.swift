//
//  DataManager.swift
//  OpenWeather
//
//  Created by jinda on 2022/7/15.
//

import Foundation
import Alamofire
import Combine

// Custom Network error enum
struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

// Open Weather backend error
struct BackendError: Codable, Error {
    var cod: Int
    var message: String
}

// API URL
struct APIUrl {
    // get APIKey from plist
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Open-API", ofType: "plist") else {
          fatalError("Couldn't find file 'Open-API.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Open-API.plist'.")
        }
        return value
      }
    }
    
    // Service endpoint
    private var endpoint: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Open-API", ofType: "plist") else {
          fatalError("Couldn't find file 'Open-API.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "END_POINT") as? String else {
          fatalError("Couldn't find key 'END_POINT' in 'Open-API.plist'.")
        }
        return value
      }
    }

    let apiKeyPrefix = "&appid="

    func weatherUrlByCity(_ city: City) -> String {
        return endpoint + "lat=\(city.lat)&lon=\(city.lon)" + apiKeyPrefix + apiKey
    }
}

// Service protocol
protocol ServiceProtocol {
    func fetchWeatherByCity(_ city: City) -> AnyPublisher<DataResponse<WeatherItem, NetworkError>, Never>
}

// Service
class Service {
    // service singleton shared instance
    static let shared: ServiceProtocol = Service()
    private init() { }
}

// Service implementation
extension Service: ServiceProtocol {
    func fetchWeatherByCity(_ city: City) -> AnyPublisher<DataResponse<WeatherItem, NetworkError>, Never> {
        let apiUrl = APIUrl()

        let url = URL(string: apiUrl.weatherUrlByCity(city))!
        
        return AF.request(url, method: .get, requestModifier: { $0.timeoutInterval = 15 }).validate()
            .publishDecodable(type: WeatherItem.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher() // flat generic types to anyPublisher
    }
}
