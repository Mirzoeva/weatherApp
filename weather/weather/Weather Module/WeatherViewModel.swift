//
//  WeatherViewModel.swift
//  weather
//
//  Created by Ума Мирзоева on 20.11.2020.
//

protocol WeatherViewModelProtocol {
    func sendSearchBarData(searchQuery: String)
}

class WeatherViewModel: WeatherViewModelProtocol {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func sendSearchBarData(searchQuery: String) {
       networkService.getCityWeather(name: searchQuery)
    }
    
}
