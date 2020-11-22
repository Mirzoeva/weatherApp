//
//  WeatherDetailedViewModel.swift
//  weather
//
//  Created by Ума Мирзоева on 22.11.2020.
//

import Foundation

protocol WeatherDetailedViewModelProtocol {
    
}

class WeatherDetailedViewModel: WeatherDetailedViewModelProtocol {
    private let networkService: NetworkService
    
    let cityName: String
    
    var dataSource: [List] = []
    
    
    init(networkService: NetworkService, cityName: String) {
        self.networkService = networkService
        self.cityName = cityName
    }
    
    func loadCityForecast(completion: @escaping () -> Void) {
        networkService.getCityForecast(
            cityname: cityName) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    guard let list = response.list else { return }
                    self.dataSource = list
                    for i in 0..<self.dataSource.count {
                        let temp = self.dataSource[i].main?.temp ?? 0.0
                        self.dataSource[i].main?.temp = temp - 273.0
                    }
                    completion()
                }
            case .failure:
                break
            }
        }
    }
    
    func loadImage(imageName: String, completion: @escaping (Data?) -> Void) {
        networkService.getWeatherImage(imageName: imageName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(data)
                case .failure:
                    completion(nil)
                }
            }
        }
    }
    
}
