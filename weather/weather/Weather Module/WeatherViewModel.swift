//
//  WeatherViewModel.swift
//  weather
//
//  Created by Ума Мирзоева on 20.11.2020.
//

import Foundation

protocol WeatherViewModelProtocol {
    func sendSearchBarData(searchQuery: String, completion: @escaping (Result<CityWeatherResponse, Error>) -> Void)
    func loadImage(
        imageName: String,
        completion: @escaping (Result<Data, Error>) -> Void
    )
}

class WeatherViewModel: WeatherViewModelProtocol {

    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func sendSearchBarData(searchQuery: String, completion: @escaping (Result<CityWeatherResponse, Error>) -> Void) {
        networkService.getCityWeather(name: searchQuery) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadImage(
        imageName: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        networkService.getWeatherImage(imageName: imageName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
