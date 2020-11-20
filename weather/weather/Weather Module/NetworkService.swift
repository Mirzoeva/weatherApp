//
//  NetworkService.swift
//  weather
//
//  Created by Ума Мирзоева on 20.11.2020.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCityWeather(name: String)
    
}

class NetworkService {
    private static let apiKey = ""
    private let searchPath = "api.openweathermap.org/data/2.5/weather?q={city name}&appid=\(apiKey)"
    
    func getCityWeather(name: String) {
        print(Endpoint.getCityWeather(name: name).url.absoluteString)
    }
    
    enum Endpoint {
        case getCityWeather(name: String)
        
        var path: String {
            switch self {
            case .getCityWeather:
                return "api.openweathermap.org/data/2.5/weather"
            }
        }
        
        var params: [String: String] {
            switch self {
            case .getCityWeather(let name):
                return [
                    "q": name,
                    "appid": NetworkService.apiKey
                ]
            }
        }
        
        var url: URL {
            var urlComponents = URLComponents(string: self.path)
            var queryItems: [URLQueryItem] = []
            for (key, value) in params {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComponents?.queryItems = queryItems
            return urlComponents!.url!
            
        }
    
    }
    
    
}
