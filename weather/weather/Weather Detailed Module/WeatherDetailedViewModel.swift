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
    
    init(networkService: NetworkService, cityName: String) {
        self.networkService = networkService
        self.cityName = cityName
    }
    
}
