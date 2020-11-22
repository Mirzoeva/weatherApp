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
                    self.dataSource = response.list
                    completion()
                }
            case .failure:
                break
            }
        }
    }
    
}
