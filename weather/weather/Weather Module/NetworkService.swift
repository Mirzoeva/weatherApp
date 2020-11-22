//
//  NetworkService.swift
//  weather
//
//  Created by Ума Мирзоева on 20.11.2020.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCityWeather(
        name: String,
        completion: @escaping (Result<CityWeatherResponse, Error>) -> Void
    )
    
    func getWeatherImage(
        imageName: String,
        completion: @escaping (Result<Data, Error>) -> Void
    )
    
}

class NetworkService {
    private static let apiKey = "73f03797062f1017f0dc06014c2df1c4"
    private let urlSession = URLSession(configuration: .default)
    
    func getCityWeather(name: String,
                        completion: @escaping (Result<CityWeatherResponse, Error>) -> Void) {
        let url = Endpoint.getCityWeather(name: name).url
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            if let data = data {
                guard let weatherResponse = try? JSONDecoder().decode(CityWeatherResponse.self, from: data) else {
                    completion(.failure(Errors.failExtractData))
                    return
                }
                completion(.success(weatherResponse))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func getWeatherImage(
        imageName: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        let url = Endpoint.getWeatherImage(name: imageName).url
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    enum Errors: Error {
        case failExtractData
    }
    
    
    enum Endpoint {
        case getCityWeather(name: String)
        case getWeatherImage(name: String)
        
        var path: String {
            switch self {
            case .getCityWeather:
                return "https://api.openweathermap.org/data/2.5/weather"
            case .getWeatherImage(let name):
                return "https://openweathermap.org/img/wn/\(name)@4x.png"
            }
        }
        
        var params: [String: String] {
            switch self {
            case .getCityWeather(let name):
                return [
                    "q": name,
                    "appid": NetworkService.apiKey
                ]
            case .getWeatherImage:
                return [:]
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
